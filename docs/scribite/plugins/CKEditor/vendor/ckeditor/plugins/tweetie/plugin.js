CKEDITOR.plugins.add('Tweetie', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertTweetie', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=Tweetie&type=external&func=finder&editor=ckeditor';
                // call method in Tweetie_Finder.js and also give current editor
                TweetieFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('tweetie', {
            label: 'Insert Tweetie object',
            command: 'insertTweetie',
         // icon: this.path + 'images/ed_tweetie.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
