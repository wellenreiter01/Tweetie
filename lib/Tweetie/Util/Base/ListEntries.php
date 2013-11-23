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
 * Utility base class for list field entries related methods.
 */
class Tweetie_Util_Base_ListEntries extends Zikula_AbstractBase
{
    /**
     * Return the name or names for a given list item.
     *
     * @param string $value      The dropdown value to process.
     * @param string $objectType The treated object type.
     * @param string $fieldName  The list field's name.
     * @param string $delimiter  String used as separator for multiple selections.
     *
     * @return string List item name.
     */
    public function resolve($value, $objectType = '', $fieldName = '', $delimiter = ', ')
    {
        if (empty($value) || empty($objectType) || empty($fieldName)) {
            return $value;
        }
    
        $isMulti = $this->hasMultipleSelection($objectType, $fieldName);
        if ($isMulti === true) {
            $value = $this->extractMultiList($value);
        }
    
        $options = $this->getEntries($objectType, $fieldName);
        $result = '';
    
        if ($isMulti === true) {
            foreach ($options as $option) {
                if (!in_array($option['value'], $value)) {
                    continue;
                }
                if (!empty($result)) {
                    $result .= $delimiter;
                }
                $result .= $option['text'];
            }
        } else {
            foreach ($options as $option) {
                if ($option['value'] != $value) {
                    continue;
                }
                $result = $option['text'];
                break;
            }
        }
    
        return $result;
    }
    

    /**
     * Extract concatenated multi selection.
     *
     * @param string  $value The dropdown value to process.
     *
     * @return array List of single values.
     */
    public function extractMultiList($value)
    {
        $listValues = explode('###', $value);
        $numValues = count($listValues);
        if ($numValues > 1 && $listValues[$numValues-1] == '') {
            unset($listValues[$numValues-1]);
        }
        if ($listValues[0] == '') {
            unset($listValues[0]);
        }
    
        return $listValues;
    }
    

    /**
     * Determine whether a certain dropdown field has a multi selection or not.
     *
     * @param string $objectType The treated object type.
     * @param string $fieldName  The list field's name.
     *
     * @return boolean True if this is a multi list false otherwise.
     */
    public function hasMultipleSelection($objectType, $fieldName)
    {
        if (empty($objectType) || empty($fieldName)) {
            return false;
        }
    
        $result = false;
        switch ($objectType) {
            case 'twitterparm':
                switch ($fieldName) {
                    case 'workflowState':
                        $result = false;
                        break;
                }
                break;
        }
    
        return $result;
    }
    

    /**
     * Get entries for a certain dropdown field.
     *
     * @param string  $objectType The treated object type.
     * @param string  $fieldName  The list field's name.
     *
     * @return array Array with desired list entries.
     */
    public function getEntries($objectType, $fieldName)
    {
        if (empty($objectType) || empty($fieldName)) {
            return array();
        }
    
        $entries = array();
        switch ($objectType) {
            case 'twitterparm':
                switch ($fieldName) {
                    case 'workflowState':
                        $entries = $this->getWorkflowStateEntriesForTwitterparm();
                        break;
                }
                break;
        }
    
        return $entries;
    }

    
    /**
     * Get 'workflow state' list entries.
     *
     * @return array Array with desired list entries.
     */
    public function getWorkflowStateEntriesForTwitterparm()
    {
        $states = array();
        $states[] = array('value' => 'approved',
                          'text'  => $this->__('Approved'),
                          'title' => $this->__('Content has been approved and is available online.'),
                          'image' => '');
        $states[] = array('value' => '!approved',
                          'text'  => $this->__('All except approved'),
                          'title' => $this->__('Shows all items except these which are approved'),
                          'image' => '');
    
        return $states;
    }
}