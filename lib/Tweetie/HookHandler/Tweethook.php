<?php
/**
 * Copyright 2009 Zikula Foundation.
 *
 * This work is contributed to the Zikula Foundation under one or more
 * Contributor Agreements and licensed to You under the following license:
 *
 * @license MIT
 *
 * Please see the NOTICE file distributed with this source code for further
 * information regarding copyright and licensing.
 */
 
class Tweetie_HookHandler_Tweethook extends Zikula_Hook_AbstractHandler
{
    /**
     * Zikula_View instance
     *
     * @var Zikula_View
     */
    private $view;
    
     /**
     * Zikula entity manager instance
     * @var object
     */
    private $_em;

    /**
     * Post constructor hook.
     *
     * @return void
     */
    public function setup()
    {
        $this->view = Zikula_View::getInstance("Tweetie");
        $this->_em = ServiceUtil::getService('doctrine.entitymanager');
        
    }

    /**
     * Display hook for view.
     *
     * Subject is the object being viewed that we're attaching to.
     * args[id] is the id of the object.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
     
     /*
    public function ui_view(Zikula_DisplayHook $hook)
    {
        // Security check
        if (!SecurityUtil::checkPermission('Tweetie::', '::', ACCESS_READ)) {
            return;
        }

        // do some stuff here like get data from database to show in template
        // our example doesn't have any data to fetch, so we will create a random number to show :)
        $tweethook_data = array('dummydata' => rand(1,9));
        $this->view->assign('tweethook_data', $tweethook_data);

        // add this response to the event stack
        $response = new Zikula_Response_DisplayHook('provider.tweetie.ui_hooks.tweethook', $this->view, 'tweetie_hook_tweethook_ui_view.tpl');
        $hook->setResponse($response);
    }
*/
     /**
     * Display hook for edit views.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
     /*
    public function ui_edit(Zikula_DisplayHook $hook)
    {
        // get data from $event
        $id = $hook->getId();

        if (!$id) {
            $access_type = ACCESS_ADD;
        } else {
            $access_type = ACCESS_EDIT;
        }

        // Security check
        if (!SecurityUtil::checkPermission('Tweetie::', '::', $access_type)) {
            return;
        }

        // if validation object does not exist, this is the first time display of the create/edit form.
        if (!$this->validation) {
            // either display an empty form,
            // or fill the form with existing data
            if (!$id) {
                // this is a create action so create a new empty object for editing
                $tweethook_data = array('dummydata' => '');
            } else {
                // this is an edit action so we probably need to get the data from the DB for editing
                // for this example however, we don't have any data stored in db, so display something random :)
                $tweethook_data = array('dummydata' => rand(1,9));
            }
        } else {
            // this is a re-entry because the form didn't validate.
            // We need to gather the input from the form and render display
            // get the input from the form (this was populated by the validation hook).
            $tweethook_data = $this->validation->getObject();
        }

        // assign the hook data to the template
        $this->view->assign('tweethook_data', $tweethook_data);

        // and also assign the id
        $this->view->assign('id', $id);

        // add this response to the event stack
        $response = new Zikula_Response_DisplayHook('provider.tweetie.ui_hooks.tweethook', $this->view, 'tweetie_hook_tweethook_ui_edit.tpl');
        $hook->setResponse($response);
    }
*/
    /**
     * Display hook for delete views.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
/*
    public function ui_delete(Zikula_DisplayHook $hook)
    {
        // Security check
        if (!SecurityUtil::checkPermission('Tweetie::', '::', ACCESS_DELETE)) {
            return;
        }

        // do some stuff here like get data from database to show in template
        // our example doesn't have any data to fetch, so we will create a random number to show :)
        $tweethook_data = array('dummydata' => rand(1,9));
        $this->view->assign('tweethook_data', $tweethook_data);

        // add this response to the event stack
        $response = new Zikula_Response_DisplayHook('provider.tweetie.ui_hooks.tweethook', $this->view, 'tweetie_hook_tweethook_ui_delete.tpl');
        $hook->setResponse($response);
    }
*/
    /**
     * Filter hook for view
     *
     * Subject is the object being viewed that we're attaching to.
     * args[id] is the id of the object.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
/*     
    public static function ui_filter(Zikula_FilterHook $hook)
    {
        $data = $hook->getData();
        $data .= "<br />" . $this->__('This data has been transformed by adding this text.');
        $hook->setData($data);
    }
*/
    /**
     * validation handler for validate_edit hook type.
     *
     * The property $event->data is an instance of Zikula_Collection_HookValidationProviders
     * Use the $event->data->set() method to log the validation response.
     *
     * This method populates this hookhandler object with a Zikula_Hook_ValidationResponse
     * so the information is available to the ui_edit method if validation fails,
     * and so the process_* can write the validated data to the database.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
/*
    public function validate_edit(Zikula_ValidationHook $hook)
    {
        // get data from post
        $tweethook_data = FormUtil::getPassedValue('tweethook_data', null, 'POST');

        // create a new hook validation object and assign it to $this->validation
        $this->validation = new Zikula_Hook_ValidationResponse('tweethook_data', $tweethook_data);

        // do the actual validation
        // for this example, the validation passes if our dummydata is a number between 1 and 9
        // otherwise the validation fais
        if (!is_numeric($tweethook_data['dummydata']) || ((int)$tweethook_data['dummydata'] < 1 || (int)$tweethook_data['dummydata'] > 9)) {
            $this->validation->addError('dummydata', 'You must fill a number between 1 and 9.');
        }

        $hook->setValidator('provider.tweetie.ui_hooks.tweethook', $this->validation);
    }
*/
    /**
     * validation handler for validate_delete hook type.
     *
     * The property $event->data is an instance of Zikula_Collection_HookValidationProviders
     * Use the $event->data->set() method to log the validation response.
     *
     * This method populates this hookhandler object with a Zikula_Hook_ValidationResponse
     * so the information is available to the ui_edit method if validation fails,
     * and so the process_* can write the validated data to the database.
     *
     * @param Zikula_ValidationHook $hook
     *
     * @return void
     */
/*
     public function validate_delete(Zikula_ValidationHook $hook)
    {
        // nothing to do here really, just return
        // if however i wanted to check for something, i would do it like the
        // validate_edit function!!! [make sure you check ui_edit and process_edit also]

        return;
    }
*/

function send_to_twitter($item, $message, $linkback)
    {           
      include_once ('modules/Tweetie/lib/vendor/Oauth/twitteroauth.php');
	$twitter = new TwitterOAuth ($item->getConsumerKey(),$item->getConsumerSecret(),$item->getAccessKey(),$item->getAccessSecret());
	$max = 140 -strlen($linkback);
 	if (strlen($message) > $max) { 
  			$message = substr($message, 0, $max-2).'..';
	}
	$twitter->post('statuses/update', array('status' => 'Neues Blog: ' .$message.' '.$linkback));
 
    }
    
   
      
      
    /**
     * process edit hook handler.
     *
     * This should be executed only if the validation has succeeded.
     * This is used for both new and edit actions.  We can determine which
     * by the presence of an ID field or not.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
      
    public function process_edit(Zikula_ProcessHook $hook)
    {
        // check for validation here
  //      if (!$this->validation) {
  //          return;
 //       }
        
            switch ($hook->getCaller()) {
            case 'News' :
                         $newsItem = ModUtil::apiFunc('News', 'user', 'get', array('sid' => $hook->getId()));
                         //until we have something to do
                      //   LogUtil::addStatusPopup( 'Newstitle: '.$newsItem['title']);
                      //    LogUtil::addStatusPopup( $this-name);
                         
                         if ($newsItem['published_status'] == 0) { // == News_Api_User::status_published
				$entity = ModUtil::apiFunc('Tweetie', 'selection', 'getEntity',array ('id' => 1,'ot' => 'twitterparm', 'usejoins' => false));
				if (!$entity) { 
				      LogUtil::addStatusPopup('Tweetie: no Item found');
				      return;
				}
				$this->send_to_twitter($entity, $newsItem['title']);
			 } else 
			 {
				LogUtil::addStatusPopup('Tweetie: no Tweet created');
			  }
			    
			
			
			 
			     
                        
                         
                         break;
                /*         
	    case 'PostCalendar':
			 // to be done
			  $em = ServiceUtil::getService('doctrine.entitymanager');
			  $event = $em->getRepository('PostCalendar_Entity_CalendarEvent')->find($this->eid);
			  if (isset($event)) {
			      $event = $event->getOldArray();
			  } else {
			      return LogUtil::registerError($this->view->__('Error: Can not find event.'));
			  }
                         break;
	    */
	    default: LogUtil::addErrorPopup('Das Modul '.$hook->getCaller().' wird von tweetie nicht unterstuetzt');
           } //case
    
    }

    /**
     * delete process hook handler.
     *
     * The subject should be the object that was deleted.
     * args[id] Is the is of the object
     * args[caller] is the name of who notified this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
/*     
    public function process_delete(Zikula_ProcessHook $hook)
    {
        // this example does not have an data stored in database to delete
        // however, if i had any, i would execute a db call here to delete them
    }
    */
   
    
}
