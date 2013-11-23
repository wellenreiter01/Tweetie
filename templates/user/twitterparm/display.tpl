{* purpose of this template: twitterparms display view in user area *}
{include file='user/header.tpl'}
<div class="tweetie-twitterparm tweetie-display">
{gt text='Twitterparm' assign='templateTitle'}
{assign var='templateTitle' value=$twitterparm.consumerKey|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'tweetie.filter_hooks.twitterparms.filter'} ({$twitterparm.workflowState|tweetieObjectState:false|lower}){icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>


<dl>
    <dt>{gt text='Consumer secret'}</dt>
    <dd>{$twitterparm.consumerSecret}</dd>
    <dt>{gt text='Access key'}</dt>
    <dd>{$twitterparm.accessKey}</dd>
    <dt>{gt text='Access secret'}</dt>
    <dd>{$twitterparm.accessSecret}</dd>
    <dt>{gt text='Hashtag'}</dt>
    <dd>{$twitterparm.hashtag}</dd>
    
</dl>
{include file='user/include_standardfields_display.tpl' obj=$twitterparm}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='tweetie.ui_hooks.twitterparms.display_view' id=$twitterparm.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
    {if count($twitterparm._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$twitterparm._actions}
            <a href="{$option.url.type|tweetieActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                tweetyInitItemActions('twitterparm', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
{/if}

</div>
</div>
{include file='user/footer.tpl'}

