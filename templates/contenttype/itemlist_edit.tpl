{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_tweetie' assign='objectTypeSelectorLabel'}
    {formlabel for='Tweetie_objecttype' text=$objectTypeSelectorLabel}
    {tweetieObjectTypeSelector assign='allObjectTypes'}
    {formdropdownlist id='Tweetie_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
    <div class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_tweetie'}</div>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='Tweetie' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_tweetie' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_tweetie' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="Tweetie_catids`$propertyName`" text=$categorySelectorLabel}
            {formdropdownlist id="Tweetie_catids`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
            <div class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_tweetie'}</div>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_tweetie' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='Tweetie_srandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_tweetie' assign='sortingRandomLabel'}
        {formlabel for='Tweetie_srandom' text=$sortingRandomLabel}
        {formradiobutton id='Tweetie_snewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_tweetie' assign='sortingNewestLabel'}
        {formlabel for='Tweetie_snewest' text=$sortingNewestLabel}
        {formradiobutton id='Tweetie_sdefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_tweetie' assign='sortingDefaultLabel'}
        {formlabel for='Tweetie_sdefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_tweetie' assign='amountLabel'}
    {formlabel for='Tweetie_amount' text=$amountLabel}
    {formintinput id='Tweetie_amount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_tweetie' assign='templateLabel'}
    {formlabel for='Tweetie_template' text=$templateLabel}
    {tweetieTemplateSelector assign='allTemplates'}
    {formdropdownlist id='Tweetie_template' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customtemplatearea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_tweetie' assign='customTemplateLabel'}
    {formlabel for='Tweetie_customtemplate' text=$customTemplateLabel}
    {formtextinput id='Tweetie_customtemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
    <div class="z-sub z-formnote">{gt text='Example' domain='module_tweetie'}: <em>itemlist_[objecttype]_display.tpl</em></div>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_tweetie' assign='filterLabel'}
    {formlabel for='Tweetie_filter' text=$filterLabel}
    {formtextinput id='Tweetie_filter' dataField='filter' group='data' mandatory=false maxLength=255}
    <div class="z-sub z-formnote">({gt text='Syntax examples' domain='module_tweetie'}: <kbd>name:like:foobar</kbd> {gt text='or' domain='module_tweetie'} <kbd>status:ne:3</kbd>)</div>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function tweetyToggleCustomTemplate() {
        if ($F('Tweetie_template') == 'custom') {
            $('customtemplatearea').removeClassName('z-hide');
        } else {
            $('customtemplatearea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        tweetyToggleCustomTemplate();
        $('Tweetie_template').observe('change', function(e) {
            tweetyToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
