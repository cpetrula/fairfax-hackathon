var sol = sol || {};
sol.Utils = (function () {

    function getObjects (obj, key, val) {
        var objects = [];
        for (var i in obj) {
            if (!obj.hasOwnProperty(i)) continue;
            if (typeof obj[i] == 'object') {
                objects = objects.concat(getObjects(obj[i], key, val));
            } else if (i == key && obj[key] == val) {
                objects.push(obj);
            }
        }
        return objects;
    }

    function setCookie (cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires="+ d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function deleteCookie (cname) {
        document.cookie=cname + "=;expires=Wed 01 Jan 1970;path=/";
    }

    function getCookie (cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for(var i = 0; i <ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function gup ( name ) {
      name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
      var regexS = "[\\?&]"+name+"=([^&]*)";
      var regex = new RegExp( regexS );
      var results = regex.exec( window.location.href );
      if( results == null )
        return "";
      else
        return results[1];
    }

    function formatCurrency(num,showCents) {
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
        num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
        cents = "0" + cents;
        cents = (showCents) ? "."+cents : "";
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
        num = num.substring(0,num.length-(4*i+3))+','+
        num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + '$' + num + cents);
    }

    function printPage() {
        var $iframe = $('iframe');
        
        var content = $("#main-content").html();

        $iframe.contents().find('body').empty().append($(content));
        var css = $("style")[0].innerText;
        $iframe.contents().find('head').empty().append($('<style type="text/css">' + css + '</style>'));
        var stylesheets=$("link[rel=stylesheet");
        $.each(stylesheets,function(index,value) {
            var href=$(value).attr("href");
            console.log(href);
             $iframe.contents().find('head').append($('<link rel="stylesheet" href="'+href+'">'));
        });
        
        window.setTimeout(function() {document.printframe.print()},3000);  

    }

    function getTODGreeting () {
        var dt=new Date();
        if (dt.getHours() < 12) {
            return "Good Morning";
        }
        else if (dt.getHours() >=12 && dt.getHours() <=17) {
            return "Good Afternoon";
        }
        else return "Good Evening";
    }

    function sortTable (table,fieldName) {
        $.each($("th",table), function (index) {
            var fieldLabel=$(this).text();
            console.log("fieldName:"+fieldLabel);
            if (fieldLabel.toLowerCase()==fieldName.replace("by ","").toLowerCase()) {
                $(table).DataTable().order([index,'desc']).draw();
            }
        });
    }
    
    function getGeoLocation () {
            return fetch('https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyC5oLwQ4kz0841rw4rk-5foOJeCdIiaNQM', {
                method: 'POST'})
                .then((resp) => {
                    if (!resp.ok) {
                        console.log(resp);
                        throw new Error("Bad response while getting geo coordinates!")
                    }
                    return resp.json();
                })
                .then((geo) => {
                    console.log("Got geo", geo);
                    var loc = geo.location;
                    return fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${loc.lat},${loc.lng}&key=AIzaSyC5oLwQ4kz0841rw4rk-5foOJeCdIiaNQM`);
                })
                .then((resp) => {
                    if (!resp.ok) {
                        console.log(resp);
                        throw new Error("Bad response while getting province from geo");
                    }

                    return resp.json();
                })
                .then((location) => {
                    console.log("Successfully automagicked location!", location);

                    var cityResult = location.results.find((result) => {
                        return result.types.indexOf("administrative_area_level_1") !== -1;
                    });
                    var city = cityResult.address_components.find((comp) => {
                        return comp.types.indexOf("administrative_area_level_1") !== -1;
                    }).short_name;

                    this.placeId = cityResult.place_id;
                   return Promise.resolve(city);
                    
                })
                .catch((err) => {
                    console.log(err);
                    alert(err);
                })
    
    
    }

    return {
        getObjects:getObjects,
        gup:gup,
        setCookie:setCookie,
        getCookie:getCookie,
        deleteCookie:deleteCookie,
        formatCurrency:formatCurrency,
        printPage:printPage,
        getTODGreeting:getTODGreeting,
        sortTable:sortTable,
        getGeoLocation : getGeoLocation
    }  
}());

