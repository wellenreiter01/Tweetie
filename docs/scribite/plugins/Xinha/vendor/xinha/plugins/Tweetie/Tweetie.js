// Tweetie plugin for Xinha
// developed by Wellenreiter
//
// requires Tweetie module (http://www.keine.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function Tweetie(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'Tweetie',
        tooltip  : 'Insert Tweetie object',
     // image    : _editor_url + 'plugins/Tweetie/img/ed_Tweetie.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=Tweetie&type=external&func=finder&editor=xinha';
            TweetieFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('Tweetie', 'insertimage', 1);
}

Tweetie._pluginInfo = {
    name          : 'Tweetie for xinha',
    version       : '1.0.0',
    developer     : 'Wellenreiter',
    developer_url : 'http://www.keine.de',
    sponsor       : 'ModuleStudio 0.6.0',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
