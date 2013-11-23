{* purpose of this template: inclusion template for display of related twitterparms in admin area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="relatedItemList twitterparm">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='Tweetie' type='admin' func='display' ot='twitterparm' id=$item.id}" title="{$item.consumerKey|replace:"\"":""}">
{/if}
{$item.consumerKey}
{if !$nolink}
    </a>
    <a id="twitterparmItem{$item.id}Display" href="{modurl modname='Tweetie' type='admin' func='display' ot='twitterparm' id=$item.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        tweetyInitInlineWindow($('twitterparmItem{{$item.id}}Display'), '{{$item.consumerKey|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
{/foreach}
</ul>
{/if}
