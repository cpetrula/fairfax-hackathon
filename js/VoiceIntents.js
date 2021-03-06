var sol=sol || {};
sol.VoiceIntents = (function() {
    var fontSize=100;
    var search = function (response) {
				console.log("search response from dialog flow")
        console.log(response);
        if (response.status.code===200) {
            var intentName=response.result.metadata.intentName;
          	if (intents[intentName]) intents[intentName](response);
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

		var buyNow = function(response) {
            var params = response.result.paramaters;
            window.sol.tagIdMap["quote-form"].showBuyNow();
        }

        var myIntent = function(response) {
            var params = response.result.parameters;

            var quoteForm = window.sol.tagIdMap["quote-form"];
            var quoteForm2 = quoteForm.quoteForm2;

            // params.con
            var coverage_type = params["Coverage_type"];
            var coverage_direction = params["Coverage_direction"];
            if (coverage_type == "INSTALLATION" || coverage_type == "DATA") {
                var radio_button_up = $("input[name='" + coverage_type + "'][ref='yes']");
                var radio_button_down = $("input[name='" + coverage_type + "'][ref='no']");

                if (coverage_direction == 1 || coverage_direction == "up") {
                    radio_button_down && radio_button_down.removeAttr('checked');
                    radio_button_up && radio_button_up.attr('checked', 'checked');
                } else if (coverage_direction == 0 || coverage_direction == "down") {
                    radio_button_up && radio_button_up.removeAttr('checked');
                    radio_button_down && radio_button_down.attr('checked', 'checked');
                }
                quoteForm2.rangeSliderChanged();
            } else {
                if (coverage_direction == 1 || coverage_direction == "up") {
                    quoteForm2.getSliderByName(coverage_type).increaseRangeValue();
                } else if (coverage_direction == 0 || coverage_direction == "down") {
                    quoteForm2.getSliderByName(coverage_type).decreaseRangeValue();
                }
            }
        }

    var intents = {
        "my.location": myLocation,
				"site.navigation": navigation,
				"quote.get":quote,
        "start.over": function() {location.reload(); },
        "buy.now": buyNow,
        "quote.get":quote,
        "slider.prompt": myIntent
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