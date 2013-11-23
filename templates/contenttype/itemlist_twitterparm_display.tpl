{* Purpose of this template: Display twitterparms within an external context *}
{foreach item='twitterparm' from=$items}
    <h3>{$twitterparm.consumerKey}</h3>
    <p><a href="{modurl modname='Tweetie' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
