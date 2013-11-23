{* Purpose of this template: Display twitterparms in text mailings *}
{foreach item='twitterparm' from=$items}
{$twitterparm.consumerKey}
{modurl modname='Tweetie' type='user' func='display' ot=$objectType id=$twitterparm.id fqurl=true}
-----
{foreachelse}
{gt text='No twitterparms found.'}
{/foreach}
