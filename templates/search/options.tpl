{* Purpose of this template: Display search options *}
<input type="hidden" id="active_tweetie" name="active[Tweetie]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_tweetie_twitterparms" name="search_tweetie_types['twitterparm']" value="1"{if $active_twitterparm} checked="checked"{/if} />
    <label for="active_tweetie_twitterparms">{gt text='Twitterparms' domain='module_tweetie'}</label>
</div>
