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
 * Event handler implementation class for page-related events.
 */
class Tweetie_Listener_Page extends Tweetie_Listener_Base_Page
{
    /**
     * Listener for the `pageutil.addvar_filter` event.
     *
     * Used to override things like system or module stylesheets or javascript.
     * Subject is the `$varname`, and `$event->data` an array of values to be modified by the filter.
     *
     * This single filter can be used to override all css or js scripts or any other var types
     * sent to `PageUtil::addVar()`.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function pageutilAddvarFilter(Zikula_Event $event)
    {
        parent::pageutilAddvarFilter($event);
    
        // Simply test with something like
        /*
            if (($key = array_search('system/Users/javascript/somescript.js', $event->data)) !== false) {
                $event->data[$key] = 'config/javascript/myoverride.js';
            }
        */
    }
    
    /**
     * Listener for the `system.outputfilter` event.
     *
     * Filter type event for output filter HTML sanitisation.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function systemOutputFilter(Zikula_Event $event)
    {
        parent::systemOutputFilter($event);
    }
}
