{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="twitterparm{$twitterparm.id}">
<dt>{$twitterparm.consumerKey|notifyfilters:'tweetie.filter_hooks.twitterparms.filter'|htmlentities}</dt>
{if $twitterparm.consumerKey ne ''}<dd>{$twitterparm.consumerKey}</dd>{/if}
</dl>
