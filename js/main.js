var sol = sol || {};
sol.Main = (function () {
    var init = function () {
//       $('#calculator').jqSlideOutPanel({
//           position:"right",
//           width:"300px",
//           action:"push",
//           showToggle:false,
//           showCloseIcon:true,
//           showModalMask:false
//       });

//       $("#slide-out-nav-toggle-btn").on("click",function() {
//           $("#calculator").jqSlideOutPanel("open");
//       })
    }
    var loadTags = function () {
        var tags=zenith.CP.user.config.tags;
        var tagCount=tags.length;
        var tagLoadedCounter=0;

        for (var i=0; i< tags.length; i++) {
            riot.compile('components/'+tags[i]+'.tag', function(a) {
                tagLoadedCounter++;
                if (tagLoadedCounter===(tagCount)) { //check to see if all tags have been compiled
                    buildPage();
                }
            })
        }
        
    }
    var buildPage = function () {
        //mount footer
        riot.mount("#site-footer",'zic-footer-insured');
        //mount header
        riot.mount("#site-header",'zic-top-nav',{"data":zenith.CP.user.config});
        riot.mount("#voice-command-help-container",'zic-voice-command-help');

    }
    return {
        init: init
    }
}());
