{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='twitterparm'}
<div id="{$baseID}_preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Twitterparm information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='z-hide'}
    <div id="{$baseID}_previewcontainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}_id"{$leftSide}>{gt text='Twitterparm'}:</label>
    <select id="{$baseID}_id" name="id"{$rightSide}>
        {foreach item='twitterparm' from=$items}{strip}
            <option value="{$twitterparm.id}"{if $selectedId eq $twitterparm.id} selected="selected"{/if}>
                {$twitterparm.consumerKey}
            </option>{/strip}
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}_sort" name="sort"{$rightSide}>
        <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
        <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
        <option value="consumerKey"{if $sort eq 'consumerKey'} selected="selected"{/if}>{gt text='Consumer key'}</option>
        <option value="consumerSecret"{if $sort eq 'consumerSecret'} selected="selected"{/if}>{gt text='Consumer secret'}</option>
        <option value="accessKey"{if $sort eq 'accessKey'} selected="selected"{/if}>{gt text='Access key'}</option>
        <option value="accessSecret"{if $sort eq 'accessSecret'} selected="selected"{/if}>{gt text='Access secret'}</option>
        <option value="hashtag"{if $sort eq 'hashtag'} selected="selected"{/if}>{gt text='Hashtag'}</option>
        <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
        <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
        <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
    </select>
    <select id="{$baseID}_sortdir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_searchterm"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}_searchterm" name="searchterm"{$rightSide} />
    <input type="button" id="Tweetie_gosearch" name="gosearch" value="{gt text='Filter'}" />
    <br{$break} />
</p>
<br />
<br />

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        tweetie.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
