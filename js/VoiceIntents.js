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
                // function scrollDown() {
                //     window.scroll(0,currentLoc+200);
                //     currentLoc=window.scrollY;
                //     if (currentLoc < totalHeight) {
                //         scrollTimer = setTimeout(function() {
                //             scrollDown();
                //         },500);
                //     }
                // }
                // scrollDown();
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
    var listgrid = function (response) {
        var params = response.result.parameters;
        var action = params.zen_navigation_action;
        var fieldName = params.any;
        if ($(".dataTable").length==1) {
            var table=$(".dataTable");
            if (action=="sort" && fieldName != "") {
                sol.Utils.sortTable(table,fieldName);
            }
            if (action=="filter" && fieldName != "") {
                table.DataTable().search(fieldName).draw();
            }
            if (action == "clear" || action == "reset" || action == "empty") {
                table.DataTable().search("").draw();
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
			console.log("quote function")
			console.log(response);
			window.sol.tagIdMap["quote-form"].startQuote(response);
		}
    /*
    var claims = function (response) {
        var params=response.result.parameters;
        if (!!params.any) {
            document.location.href="#/claims/claim/651674";
        }
        else {
            document.location.href="#/claims";
        }
    }
    var contacts = function (response) {
        document.location="mailto:"+$(".agent-email-link").text();
    }
    var policy = function (response) {
       // alert("test")
        var params=response.result.parameters;
        //if (params.zen_doc_type=="loss run") {
            $("a.loss-run-report")[0].click();
        //}
        
    }
    */
    var intents = {
        "my.location": myLocation,
				"site.navigation": navigation,
				"quote.get":quote
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