{* purpose of this template: build the Form to edit an instance of twitterparm *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/Tweetie/javascript/Tweetie_editFunctions.js'}
{pageaddvar name='javascript' value='modules/Tweetie/javascript/Tweetie_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit twitterparm' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create twitterparm' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit twitterparm' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="tweetie-twitterparm tweetie-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {tweetieFormFrame}

    {formsetinitialfocus inputId='consumerKey'}


    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='consumerKey' __text='Consumer key' mandatorysym='1'}
            {formtextinput group='twitterparm' id='consumerKey' mandatory=true readOnly=false __title='Enter the consumer key of the twitterparm' textMode='singleline' maxLength=255 cssClass='required' }
            {tweetieValidationError id='consumerKey' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='consumerSecret' __text='Consumer secret' mandatorysym='1'}
            {formtextinput group='twitterparm' id='consumerSecret' mandatory=true readOnly=false __title='Enter the consumer secret of the twitterparm' textMode='singleline' maxLength=100 cssClass='required' }
            {tweetieValidationError id='consumerSecret' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='accessKey' __text='Access key' mandatorysym='1'}
            {formtextinput group='twitterparm' id='accessKey' mandatory=true readOnly=false __title='Enter the access key of the twitterparm' textMode='singleline' maxLength=80 cssClass='required' }
            {tweetieValidationError id='accessKey' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='accessSecret' __text='Access secret' mandatorysym='1'}
            {formtextinput group='twitterparm' id='accessSecret' mandatory=true readOnly=false __title='Enter the access secret of the twitterparm' textMode='singleline' maxLength=255 cssClass='required' }
            {tweetieValidationError id='accessSecret' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='hashtag' __text='Hashtag' mandatorysym='1'}
            {formtextinput group='twitterparm' id='hashtag' mandatory=true readOnly=false __title='Enter the hashtag of the twitterparm' textMode='singleline' maxLength=8 cssClass='required' }
            {tweetieValidationError id='hashtag' class='required'}
        </div>
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$twitterparm}
    {/if}
    
    {* include display hooks *}
    {assign var='hookid' value=null}
    {if $mode ne 'create'}
        {assign var='hookid' value=$twitterparm.id}
    {/if}
    {notifydisplayhooks eventname='tweetie.ui_hooks.twitterparms.form_edit' id=$hookId assign='hooks'}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='twitterparm' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this twitterparm?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/tweetieFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        tweetyAddCommonValidationRules('twitterparm', '{{if $mode ne 'create'}}{{$twitterparm.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.tweetieFormTooltips'));
    });

/* ]]> */
</script>
