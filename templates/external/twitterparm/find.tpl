{* Purpose of this template: Display a popup selector of twitterparms for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select twitterparm'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/Tweetie/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/Tweetie/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
        <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.ImageViewer.js"></script>
{*            <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/prototype.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/scriptaculous.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/dragdrop.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/effects.js"></script>*}
    <script type="text/javascript" src="{$baseurl}modules/Tweetie/javascript/Tweetie_finder.js"></script>
{if $editorName eq 'tinymce'}
    <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
{/if}
</head>
<body>
    <form action="{$ourEntry|default:'index.php'}" id="selectorForm" method="get" class="z-form">
    <div>
        <input type="hidden" name="module" value="Tweetie" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select twitterparm'}</legend>

            <div class="z-formrow">
                <label for="Tweetie_pasteas">{gt text='Paste as'}:</label>
                <select id="Tweetie_pasteas" name="pasteas">
                    <option value="1">{gt text='Link to the twitterparm'}</option>
                    <option value="2">{gt text='ID of twitterparm'}</option>
                </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="Tweetie_objectid">{gt text='Twitterparm'}:</label>
                <div id="tweetyitemcontainer">
                    <ul>
                    {foreach item='twitterparm' from=$items}
                        <li>
                            <a href="#" onclick="tweetie.finder.selectItem({$twitterparm.id})" onkeypress="tweetie.finder.selectItem({$twitterparm.id})">
                                {$twitterparm.consumerKey}
                            </a>
                            <input type="hidden" id="url{$twitterparm.id}" value="{modurl modname='Tweetie' type='user' func='display' ot='twitterparm' id=$twitterparm.id fqurl=true}" />
                            <input type="hidden" id="title{$twitterparm.id}" value="{$twitterparm.consumerKey|replace:"\"":""}" />
                            <input type="hidden" id="desc{$twitterparm.id}" value="{capture assign='description'}{if $twitterparm.consumerKey ne ''}{$twitterparm.consumerKey}{/if}
                            {/capture}{$description|strip_tags|replace:"\"":""}" />
                        </li>
                    {foreachelse}
                        <li>{gt text='No entries found.'}</li>
                    {/foreach}
                    </ul>
                </div>
            </div>

            <div class="z-formrow">
                <label for="Tweetie_sort">{gt text='Sort by'}:</label>
                <select id="Tweetie_sort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
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
                <select id="Tweetie_sortdir" name="sortdir" style="width: 100px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="Tweetie_pagesize">{gt text='Page size'}:</label>
                <select id="Tweetie_pagesize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="Tweetie_searchterm">{gt text='Search for'}:</label>
                <input type="text" id="Tweetie_searchterm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
                <input type="button" id="Tweetie_gosearch" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>

            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
            <input type="submit" id="Tweetie_submit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="Tweetie_cancel" name="cancelButton" value="{gt text='Cancel'}" />
            <br />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            tweetie.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="tweetyform">
        <fieldset>
            {modfunc modname='Tweetie' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
