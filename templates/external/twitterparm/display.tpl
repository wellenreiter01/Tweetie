{* Purpose of this template: Display one certain twitterparm within an external context *}
<div id="twitterparm{$twitterparm.id}" class="tweetyexternaltwitterparm">
{if $displayMode eq 'link'}
    <p class="tweetyexternallink">
    <a href="{modurl modname='Tweetie' type='user' func='display' ot='twitterparm' id=$twitterparm.id}" title="{$twitterparm.consumerKey|replace:"\"":""}">
    {$twitterparm.consumerKey|notifyfilters:'tweetie.filter_hooks.twitterparms.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='Tweetie::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="tweetyexternaltitle">
            <strong>{$twitterparm.consumerKey|notifyfilters:'tweetie.filter_hooks.twitterparms.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="tweetyexternalsnippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="tweetyexternaldesc">
            {if $twitterparm.consumerKey ne ''}{$twitterparm.consumerKey}<br />{/if}
        </p>
    *}
{/if}
</div>
