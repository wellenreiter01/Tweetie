<?php
/**
 * Tweetie.
 *
 * @copyright Wellenreiter (Wellenreiter)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package Tweetie
 * @author Wellenreiter <wellenreiter01@t-online.de>.
 * @link http://www.keine.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.0 (http://modulestudio.de) at Mon Nov 18 23:11:04 CET 2013.
 */

/**
 * Utility base class for view helper methods.
 */
class Tweetie_Util_Base_View extends Zikula_AbstractBase
{
    /**
     * Determines the view template for a certain method with given parameters.
     *
     * @param Zikula_View $view       Reference to view object.
     * @param string      $type       Current type (admin, user, ...).
     * @param string      $objectType Name of treated entity type.
     * @param string      $func       Current function (main, view, ...).
     * @param array       $args       Additional arguments.
     *
     * @return string name of template file.
     */
    public function getViewTemplate(Zikula_View $view, $type, $objectType, $func, $args = array())
    {
        // create the base template name
        $template = DataUtil::formatForOS($type . '/' . $objectType . '/' . $func);
    
        // check for template extension
        $templateExtension = $this->determineExtension($view, $type, $objectType, $func, $args);
    
        // check whether a special template is used
        $tpl = (isset($args['tpl']) && !empty($args['tpl'])) ? $args['tpl'] : FormUtil::getPassedValue('tpl', '', 'GETPOST', FILTER_SANITIZE_STRING);
        if (!empty($tpl) && $view->template_exists($template . '_' . DataUtil::formatForOS($tpl) . '.' . $templateExtension)) {
            $template .= '_' . DataUtil::formatForOS($tpl);
        }
        $template .= '.' . $templateExtension;
    
        return $template;
    }

    /**
     * Utility method for managing view templates.
     *
     * @param Zikula_View $view       Reference to view object.
     * @param string      $type       Current type (admin, user, ...).
     * @param string      $objectType Name of treated entity type.
     * @param string      $func       Current function (main, view, ...).
     * @param string      $template   Optional assignment of precalculated template file.
     * @param array       $args       Additional arguments.
     *
     * @return mixed Output.
     */
    public function processTemplate(Zikula_View $view, $type, $objectType, $func, $args = array(), $template = '')
    {
        $templateExtension = $this->determineExtension($view, $type, $objectType, $func, $args);
        if (empty($template)) {
            $template = $this->getViewTemplate($view, $type, $objectType, $func, $args);
        }
    
        // look whether we need output with or without the theme
        $raw = (bool) (isset($args['raw']) && !empty($args['raw'])) ? $args['raw'] : FormUtil::getPassedValue('raw', false, 'GETPOST', FILTER_VALIDATE_BOOLEAN);
        if (!$raw && in_array($templateExtension, array('csv', 'rss', 'atom', 'xml', 'pdf', 'vcard', 'ical', 'json', 'kml'))) {
            $raw = true;
        }
    
        if ($raw == true) {
            // standalone output
            if ($templateExtension == 'pdf') {
                $template = str_replace('.pdf', '.tpl', $template);
                return $this->processPdf($view, $template);
            } else {
                $view->display($template);
            }
            System::shutDown();
        }
    
        // normal output
        return $view->fetch($template);
    }

    /**
     * Get extension of the currently treated template.
     *
     * @param Zikula_View $view       Reference to view object.
     * @param string      $type       Current type (admin, user, ...).
     * @param string      $objectType Name of treated entity type.
     * @param string      $func       Current function (main, view, ...).
     * @param array       $args       Additional arguments.
     *
     * @return array List of allowed template extensions.
     */
    protected function determineExtension(Zikula_View $view, $type, $objectType, $func, $args = array())
    {
        $templateExtension = 'tpl';
        if (!in_array($func, array('view', 'display'))) {
            return $templateExtension;
        }
    
        $extParams = $this->availableExtensions($type, $objectType, $func, $args);
        foreach ($extParams as $extension) {
            $extensionVar = 'use' . $extension . 'ext';
            $extensionCheck = (isset($args[$extensionVar]) && !empty($extensionVar)) ? $extensionVar : 0;
            if ($extensionCheck != 1) {
                $extensionCheck = (int)FormUtil::getPassedValue($extensionVar, 0, 'GET', FILTER_VALIDATE_INT);
                //$extensionCheck = (int)$this->request->query->filter($extensionVar, 0, FILTER_VALIDATE_INT);
            }
            if ($extensionCheck == 1) {
                $templateExtension = $extension;
                break;
            }
        }
    
        return $templateExtension;
    }

    /**
     * Get list of available template extensions.
     *
     * @param string $type       Current type (admin, user, ...).
     * @param string $objectType Name of treated entity type.
     * @param string $func       Current function (main, view, ...).
     * @param array  $args       Additional arguments.
     *
     * @return array List of allowed template extensions.
     */
    public function availableExtensions($type, $objectType, $func, $args = array())
    {
        $extParams = array();
        $hasAdminAccess = SecurityUtil::checkPermission('Tweetie:' . ucwords($objectType) . ':', '::', ACCESS_ADMIN);
        if ($func == 'view') {
            if ($hasAdminAccess) {
                $extParams = array('csv', 'rss', 'atom', 'xml', 'json', 'kml'/*, 'pdf'*/);
            } else {
                $extParams = array('rss', 'atom'/*, 'pdf'*/);
            }
        } elseif ($func == 'display') {
            if ($hasAdminAccess) {
                $extParams = array('xml', 'json', 'kml'/*, 'pdf'*/);
            }
        }
    
        return $extParams;
    }

    /**
     * Processes a template file using dompdf (LGPL).
     *
     * @param Zikula_View $view     Reference to view object.
     * @param string      $template Name of template to use.
     *
     * @return mixed Output.
     */
    protected function processPdf(Zikula_View $view, $template)
    {
        // first the content, to set page vars
        $output = $view->fetch($template);
    
        // make local images absolute
        $output = str_replace('img src="/', 'img src="' . dirname(ZLOADER_PATH) . '/', $output);
    
        // see http://codeigniter.com/forums/viewthread/69388/P15/#561214
        //$output = utf8_decode($output);
    
        // then the surrounding
        $output = $view->fetch('include_pdfheader.tpl') . $output . '</body></html>';
    
        $controllerHelper = new Tweetie_Util_Controller($this->serviceManager);
        // create name of the pdf output file
        $fileTitle = $controllerHelper->formatPermalink(System::getVar('sitename'))
                   . '-'
                   . $controllerHelper->formatPermalink(PageUtil::getVar('title'))
                   . '-' . date('Ymd') . '.pdf';
    
        // if ($_GET['dbg'] == 1) die($output);
    
        // instantiate pdf object
        $pdf = new DOMPDF();
        // define page properties
        $pdf->set_paper('A4');
        // load html input data
        $pdf->load_html($output);
        // create the actual pdf file
        $pdf->render();
        // stream output to browser
        $pdf->stream($fileTitle);
    
        // prevent additional output by shutting down the system
        System::shutDown();
    
        return true;
    }
}
