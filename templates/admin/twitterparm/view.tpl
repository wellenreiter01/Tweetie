{* purpose of this template: twitterparms view view in admin area *}
{include file='admin/header.tpl'}
<div class="tweetie-twitterparm tweetie-view">
{gt text='Twitterparm list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

{checkpermissionblock component='Tweetie:Twitterparm:' instance='::' level='ACCESS_EDIT'}
    {gt text='Create twitterparm' assign='createTitle'}
    <a href="{modurl modname='Tweetie' type='admin' func='edit' ot='twitterparm'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
{/checkpermissionblock}
{assign var='own' value=0}
{if isset($showOwnEntries) && $showOwnEntries eq 1}
    {assign var='own' value=1}
{/if}
{assign var='all' value=0}
{if isset($showAllEntries) && $showAllEntries eq 1}
    {gt text='Back to paginated view' assign='linkTitle'}
    <a href="{modurl modname='Tweetie' type='admin' func='view' ot='twitterparm'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='Tweetie' type='admin' func='view' ot='twitterparm' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
{/if}

{include file='admin/twitterparm/view_quickNav.tpl'}{* see template file for available options *}

<form class="z-form" id="twitterparms_view" action="{modurl modname='Tweetie' type='admin' func='handleselectedentries'}" method="post">
    <div>
        <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
        <input type="hidden" name="ot" value="twitterparm" />
        <table class="z-datatable">
            <colgroup>
                <col id="cselect" />
                <col id="cworkflowstate" />
                <col id="cconsumerkey" />
                <col id="cconsumersecret" />
                <col id="caccesskey" />
                <col id="caccesssecret" />
                <col id="chashtag" />
                <col id="citemactions" />
            </colgroup>
            <thead>
            <tr>
                <th id="hselect" scope="col" align="center" valign="middle">
                    <input type="checkbox" id="toggle_twitterparms" />
                </th>
                <th id="hworkflowstate" scope="col" class="z-left">
                    {sortlink __linktext='State' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='workflowState' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="hconsumerkey" scope="col" class="z-left">
                    {sortlink __linktext='Consumer key' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='consumerKey' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="hconsumersecret" scope="col" class="z-left">
                    {sortlink __linktext='Consumer secret' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='consumerSecret' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="haccesskey" scope="col" class="z-left">
                    {sortlink __linktext='Access key' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='accessKey' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="haccesssecret" scope="col" class="z-left">
                    {sortlink __linktext='Access secret' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='accessSecret' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="hhashtag" scope="col" class="z-left">
                    {sortlink __linktext='Hashtag' currentsort=$sort modname='Tweetie' type='admin' func='view' ot='twitterparm' sort='hashtag' sortdir=$sdir all=$all own=$own workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                </th>
                <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='twitterparm' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                <td headers="hselect" align="center" valign="top">
                    <input type="checkbox" name="items[]" value="{$twitterparm.id}" class="twitterparms_checkbox" />
                </td>
                <td headers="hworkflowstate" class="z-left z-nowrap">
                    {$twitterparm.workflowState|tweetieObjectState}
                </td>
                <td headers="hconsumerkey" class="z-left">
                    <a href="{modurl modname='Tweetie' type='admin' func='display' ot='twitterparm' id=$twitterparm.id}" title="{gt text='View detail page'}">{$twitterparm.consumerKey|notifyfilters:'tweetie.filterhook.twitterparms'}</a>
                </td>
                <td headers="hconsumersecret" class="z-left">
                    {$twitterparm.consumerSecret}
                </td>
                <td headers="haccesskey" class="z-left">
                    {$twitterparm.accessKey}
                </td>
                <td headers="haccesssecret" class="z-left">
                    {$twitterparm.accessSecret}
                </td>
                <td headers="hhashtag" class="z-left">
                    {$twitterparm.hashtag}
                </td>
                <td id="itemactions{$twitterparm.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
                    {if count($twitterparm._actions) gt 0}
                        {foreach item='option' from=$twitterparm._actions}
                            <a href="{$option.url.type|tweetieActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        {icon id="itemactions`$twitterparm.id`trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                tweetyInitItemActions('twitterparm', 'view', 'itemactions{{$twitterparm.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-admintableempty">
              <td class="z-left" colspan="8">
            {gt text='No twitterparms found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
        {/if}
        <fieldset>
            <label for="tweetie_action">{gt text='With selected twitterparms'}</label>
            <select id="tweetie_action" name="action">
                <option value="">{gt text='Choose action'}</option>
                <option value="delete">{gt text='Delete'}</option>
            </select>
            <input type="submit" value="{gt text='Submit'}" />
        </fieldset>
    </div>
</form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggle_twitterparms') != undefined) {
        $('toggle_twitterparms').observe('click', function (e) {
            Zikula.toggleInput('twitterparms_view');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
