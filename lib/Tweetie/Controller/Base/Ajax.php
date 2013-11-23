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
 * Ajax controller class.
 */
class Tweetie_Controller_Base_Ajax extends Zikula_Controller_AbstractAjax
{


    /**
     * This method is the default function handling the ajax area called without defining arguments.
     *
     * @param array $args List of arguments.
     *
     * @return mixed Output.
     */
    public function main(array $args = array())
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_OVERVIEW), LogUtil::getErrorMsgPermission());
    }
    
    
    /**
     * Retrieve item list for finder selections in Forms, Content type plugin and Scribite.
     *
     * @param array $args List of arguments.
     *
     * @return Zikula_Response_Ajax
     */
    public function getItemListFinder(array $args = array())
    {
        if (!SecurityUtil::checkPermission($this->name . '::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
    
        $objectType = 'twitterparm';
        if ($this->request->isPost() && $this->request->request->has('ot')) {
            $objectType = $this->request->request->filter('ot', 'twitterparm', FILTER_SANITIZE_STRING);
        } elseif ($this->request->isGet() && $this->request->query->has('ot')) {
            $objectType = $this->request->query->filter('ot', 'twitterparm', FILTER_SANITIZE_STRING);
        }
        $controllerHelper = new Tweetie_Util_Controller($this->serviceManager);
        $utilArgs = array('controller' => 'ajax', 'action' => 'getItemListFinder');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $utilArgs);
        }
    
        $entityClass = 'Tweetie_Entity_' . ucfirst($objectType);
        $repository = $this->entityManager->getRepository($entityClass);
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
        $titleField = $repository->getTitleFieldName();
        $descriptionField = $repository->getDescriptionFieldName();
    
        $sort = (isset($args['sort']) && !empty($args['sort'])) ? $args['sort'] : $this->request->request->filter('sort', '', FILTER_SANITIZE_STRING);
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
    
        $sdir = (isset($args['sortdir']) && !empty($args['sortdir'])) ? $args['sortdir'] : $this->request->request->filter('sortdir', '', FILTER_SANITIZE_STRING);
        $sdir = strtolower($sdir);
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }
    
        $where = ''; // filters are processed inside the repository class
        $sortParam = $sort . ' ' . $sdir;
    
        $entities = $repository->selectWhere($where, $sortParam);
    
        $slimItems = array();
        $component = $this->name . ':' . ucwords($objectType) . ':';
        foreach ($entities as $item) {
            $itemId = '';
            foreach ($idFields as $idField) {
                $itemId .= ((!empty($itemId)) ? '_' : '') . $item[$idField];
            }
            if (!SecurityUtil::checkPermission($component, $itemId . '::', ACCESS_READ)) {
                continue;
            }
            $slimItems[] = $this->prepareSlimItem($objectType, $item, $itemId, $titleField, $descriptionField);
        }
    
        return new Zikula_Response_Ajax($slimItems);
    }
    
    /**
     * Builds and returns a slim data array from a given entity.
     *
     * @param string $objectType       The currently treated object type.
     * @param object $item             The currently treated entity.
     * @param string $itemid           Data item identifier(s).
     * @param string $titleField       Name of item title field.
     * @param string $descriptionField Name of item description field.
     *
     * @return array The slim data representation.
     */
    protected function prepareSlimItem($objectType, $item, $itemId, $titleField, $descriptionField)
    {
        $view = Zikula_View::getInstance('Tweetie', false);
        $view->assign($objectType, $item);
        $previewInfo = base64_encode($view->fetch('external/' . $objectType . '/info.tpl'));
    
        $title = ($titleField != '') ? $item[$titleField] : '';
        $description = ($descriptionField != '') ? $item[$descriptionField] : '';
    
        return array('id'           => $itemId,
                     'title'        => str_replace('&amp;', '&', $title),
                     'description'  => $description,
                     'previewInfo'  => $previewInfo);
    }
}
