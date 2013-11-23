{* Purpose of this template: Display twitterparms within an external context *}
<dl>
    {foreach item='twitterparm' from=$items}
        <dt>{$twitterparm.consumerKey}</dt>
        {if $twitterparm.consumerSecret}
            <dd>{$twitterparm.consumerSecret|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Tweetie' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
