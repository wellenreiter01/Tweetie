'use strict';

var currentTweetieEditor = null;
var currentTweetieInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes() {
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function TweetieFinderXinha(editor, tweetyURL) {
    var popupAttributes;

    // Save editor for access in selector window
    currentTweetieEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(tweetyURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function TweetieFinderCKEditor(editor, tweetyURL) {
    // Save editor for access in selector window
    currentTweetieEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Tweetie&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var tweetie = {};

tweetie.finder = {};

tweetie.finder.onLoad = function (baseId, selectedId) {
    $('Tweetie_sort').observe('change', tweetie.finder.onParamChanged);
    $('Tweetie_sortdir').observe('change', tweetie.finder.onParamChanged);
    $('Tweetie_pagesize').observe('change', tweetie.finder.onParamChanged);
    $('Tweetie_gosearch').observe('click', tweetie.finder.onParamChanged)
                           .observe('keypress', tweetie.finder.onParamChanged);
    $('Tweetie_submit').addClassName('z-hide');
    $('Tweetie_cancel').observe('click', tweetie.finder.handleCancel);
};

tweetie.finder.onParamChanged = function () {
    $('selectorForm').submit();
};

tweetie.finder.handleCancel = function () {
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        tweetyClosePopup();
    } else if (editor === 'ckeditor') {
        tweetyClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId) {
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('Tweetie_pasteas');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
tweetie.finder.selectItem = function (itemId) {
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentTweetieEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentTweetieEditor.focusEditor();
            window.opener.currentTweetieEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentTweetieInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    tweetyClosePopup();
};


function tweetyClosePopup() {
    window.opener.focus();
    window.close();
}




//=============================================================================
// Tweetie item selector for Forms
//=============================================================================

tweetie.itemSelector = {};
tweetie.itemSelector.items = {};
tweetie.itemSelector.baseId = 0;
tweetie.itemSelector.selectedId = 0;

tweetie.itemSelector.onLoad = function (baseId, selectedId) {
    tweetie.itemSelector.baseId = baseId;
    tweetie.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $(baseId + '_objecttype').observe('change', tweetie.itemSelector.onParamChanged);

    if ($(baseId + '_catid') !== undefined) {
        $(baseId + '_catid').observe('change', tweetie.itemSelector.onParamChanged);
    }
    $(baseId + '_id').observe('change', tweetie.itemSelector.onItemChanged);
    $(baseId + '_sort').observe('change', tweetie.itemSelector.onParamChanged);
    $(baseId + '_sortdir').observe('change', tweetie.itemSelector.onParamChanged);
    $('Tweetie_gosearch').observe('click', tweetie.itemSelector.onParamChanged)
                           .observe('keypress', tweetie.itemSelector.onParamChanged);

    tweetie.itemSelector.getItemList();
};

tweetie.itemSelector.onParamChanged = function () {
    $('ajax_indicator').removeClassName('z-hide');

    tweetie.itemSelector.getItemList();
};

tweetie.itemSelector.getItemList = function () {
    var baseId, pars, request;

    baseId = tweetie.itemSelector.baseId;
    pars = 'objectType=' + baseId + '&';
    if ($(baseId + '_catid') !== undefined) {
        pars += 'catid=' + $F(baseId + '_catid') + '&';
    }
    pars += 'sort=' + $F(baseId + '_sort') + '&' +
            'sortdir=' + $F(baseId + '_sortdir') + '&' +
            'searchterm=' + $F(baseId + '_searchterm');

    request = new Zikula.Ajax.Request('ajax.php?module=Tweetie&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = tweetie.itemSelector.baseId;
            tweetie.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').addClassName('z-hide');
            tweetie.itemSelector.updateItemDropdownEntries();
            tweetie.itemSelector.updatePreview();
        }
    });
};

tweetie.itemSelector.updateItemDropdownEntries = function () {
    var baseId, itemSelector, items, i, item;

    baseId = tweetie.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    itemSelector.length = 0;

    items = tweetie.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (tweetie.itemSelector.selectedId > 0) {
        $(baseId + '_id').value = tweetie.itemSelector.selectedId;
    }
};

tweetie.itemSelector.updatePreview = function () {
    var baseId, items, selectedElement, i;

    baseId = tweetie.itemSelector.baseId;
    items = tweetie.itemSelector.items[baseId];

    $(baseId + '_previewcontainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (tweetie.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === tweetie.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + '_previewcontainer').update(window.atob(selectedElement.previewInfo))
                                       .removeClassName('z-hide');
    }
};

tweetie.itemSelector.onItemChanged = function () {
    var baseId, itemSelector, preview;

    baseId = tweetie.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    preview = window.atob(tweetie.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + '_previewcontainer').update(preview);
    tweetie.itemSelector.selectedId = $F(baseId + '_id');
};
