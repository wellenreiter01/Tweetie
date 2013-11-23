{* Purpose of this template: Display twitterparms in html mailings *}
{*
<ul>
{foreach item='twitterparm' from=$items}
    <li>
        <a href="{modurl modname='Tweetie' type='user' func='display' ot=$objectType id=$twitterparm.id fqurl=true}">{$twitterparm.consumerKey}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No twitterparms found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_twitterparm_display_description.tpl'}
