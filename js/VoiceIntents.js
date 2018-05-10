var sol=sol || {};
sol.VoiceIntents = (function() {
    var fontSize=100;
    var search = function (response) {
				console.log("search response from dialog flow")
        console.log(response);
        if (response.status.code===200) {
            var intentName=response.result.metadata.intentName;
          	intents[intentName](response) || null;
        }
    }
    var userInterface = function (response) {
        
        var params=response.result.parameters;
        var cssType=params.csstype;
        var color=params.color;
        var any=params.any;
        if (cssType=="font") {
            var currentFontSize=$("body").css("font-size");
            if (!!color) {
                $("body").css("color",color);
            }
            if (any=="increase") {
                fontSize=fontSize+10;
                $("body").css("font-size",fontSize+"%");
            }
            if (any=="decrease") {
                fontSize=fontSize-10;
                $("body").css("font-size",fontSize+"%");
            }
        }
        if (cssType=="background") {
            if (!!color) {
                $("body").css("background-color",color);
            }
        }

    }
    var showResolvedQuery = function (result) {
        $("#voice-indicator-icon").attr("title",result.resolvedQuery);
        $("#voice-indicator-icon").tooltip('show');
    }
    var print = function (response) {
        var params=response.result.parameters;
        sol.Utils.printPage();
    }
    var siteNavigation = function (response) {
        var params=response.result.parameters;
        var loc=params.zen_location;
        var other=params.any;
        var action=params.zen_navigation_action;
        if (loc=="home") {
            document.location="#/";
            window.scroll(0,0);
        }
        if (action=="scroll") {
            var currentLoc=window.scrollY;
            var totalHeight=document.body.offsetHeight;
            if (loc=="up") {
                window.scroll(0,currentLoc-200);
            }
            if (loc=="down") {
                window.scroll(0,currentLoc+200);
            }
            if (loc=="top") {
                window.scroll(0,0);
            }
            if (loc=="bottom") {
                window.scroll(0,totalHeight);
            }
            if (other=="pause" || other == "stop") {
                //if (scrollTimer) clearTimeout(scrollTimer);
            }
        }
    }

    var myLocation = function(response) {
        var params = response.result.parameteres;
        console.log(params);
    }
		
		var navigation = function (response) {
			var params = response.result.paramaters;
			
		}
		var quote = function (response) {
			var params = response.result.paramaters;
			window.sol.tagIdMap["quote-form"].startQuote(response);
		}

    var intents = {
        "my.location": myLocation,
				"site.navigation": navigation,
				"quote.get":quote,
        "start.over": function() {location.reload(); }
        // "user.interface": userInterface,
        // "cp.print": print,
        // "cp.claims": claims,
        // "cp.site.navigation":siteNavigation,
        // "cp.listgrid":listgrid,
        // "cp.contacts":contacts,
        // "cp.policy":policy
    }

    return {
        search : search
    }
}());