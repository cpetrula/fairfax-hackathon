/**
 * jquery.slideoutpanel.js
 * @version: v1.0.2
 * @author: Chris Petrula
 *
 * Created by Chris Petrula on 2016-01-19. 
 *
 * Copyright (c) 2016
 *
 * The MIT License (http://www.opensource.org/licenses/mit-license.php)
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

/*
------------------------------------
Options
------------------------------------
position: String[right | left]

action: String[push | overlay]

width: String[px | %]

targetNode : String[html selector] i.e. #divname

customClassName : String

showToggle: Boolean[true | false]

showCloseIcon: Boolean[true | false]

sliderOpenedCallback: function

sliderClosedCallback: function

showModalMask: Boolean[true | false]


------------------------------------
Methods
------------------------------------

open:

close:

showToggle:

hideToggle:

showCloseIcon:

hideCloseIcon:


*/

(function($){

    function JQSlideOutPanel(item, options) {
        this.options = $.extend({
          position: 'right', // right,left
          action: 'push', // push,overlay
          width:'350px', // can use px or %
          animateSpeed:200, //1000 = 1 second
          showToggle: true,
          targetNode: "body",
          customClassName: "",
          toggleIconClassLeft:"toggle-arrow-left",
          toggleIconClassRight:"toggle-arrow-right",
          showCloseIcon: false,
          sliderOpenedCallback : null,
          sliderClosedCallback : null,
          showModalMask : true
        }, options);
        var _this=this;
        this.item = $(item);
        var position=(this.options.position=="right") ? "right" : "left";
    		var animateSpeed=this.options.animateSpeed;
    		var action=this.options.action;
      
        init();

        function init() {
          _this.item.addClass("jq-slide-out-panel-content-wrapper")
          createInternalContainer();
          addToggle();
          addCloseIcon();
        }

        this.createModalMask = function() {
          _this.modalMask = $("<div>",{
            style:""
          });
          _this.modalMask.addClass("jq-slide-out-panel-modal-mask");
          _this.modalMask.appendTo("body");
          $(_this.modalMask).on("click", function() {
            _this.close();
            _this.removeModalMask();
          });
        }
        this.removeModalMask = function () {
          if (this.modalMask) this.modalMask.remove();
        }

        function createInternalContainer() {
          _this.internalContainer=$("<div>");
          _this.internalContainer.addClass("jq-slide-out-panel-container");
          if (_this.options.customClassName) _this.internalContainer.addClass(_this.options.customClassName);
          _this.internalContainer.addClass("jq-slide-out-panel-"+position);
          _this.internalContainer.css("width",_this.options.width);
          _this.internalContainer.css(position,"-"+_this.options.width);
          _this.item.appendTo(_this.internalContainer);
          _this.internalContainer.appendTo("body");
        }

        function addToggle () {
          var toggleIcon=(position=="left") ? _this.options.toggleIconClassRight : _this.options.toggleIconClassLeft;
          _this.toggle=$("<div>",{
            class:"jq-slide-out-panel-toggle",
            html:"<span class='jq-slide-out-panel-toggle-icon "+toggleIcon+"'>&nbsp;</span>"
          })
          .click(function() {
            $(_this.internalContainer).attr("is-open")=="true" ? _this.close() :  _this.open();
          });
		  
          $(_this.toggle).addClass("jq-slide-out-panel-toggle-"+position);
		  
          _this.toggle.appendTo(_this.internalContainer);
		  
          if (!_this.options.showToggle) {
            _this.hideToggle();
          }

        }

        function addCloseIcon () {
          _this.closeIconContainer = $("<div>",{
            class:"jq-slide-out-panel-close-icon-container"
          });
          var closeIcon = $("<div>",{
            class:"jq-slide-out-panel-close-icon jq-slide-out-panel-close-icon-"+position
          })
          .appendTo(_this.closeIconContainer);
          closeIcon.on("click",function() {
            _this.close();
          })
          _this.closeIconContainer.prependTo(_this.internalContainer);
          _this.item.prepend(_this.closeIconContainer);
          if (!_this.options.showCloseIcon) {
            _this.hideCloseIcon();
          }
        }

    }
    JQSlideOutPanel.prototype = {

        open : function () {
          var opts=this.options;
          var width=opts.width;
          var action=opts.action;
          var position=(opts.position=="right") ? "right" : "left";
		      var icon = $(this.internalContainer).find("span.jq-slide-out-panel-toggle-icon");
          var callback=opts.sliderOpenedCallback;
		      var animateSpeed=opts.animateSpeed;
          var toggleIconClassLeft=opts.toggleIconClassLeft;
          var toggleIconClassRight=opts.toggleIconClassRight;
          var overridePush = ($("body").width()<1000) ? true : false;

          console.log(this)

          if (opts.showModalMask) this.createModalMask();
		  
          if (position=="right") {
            $(this.internalContainer).animate({right:0},animateSpeed,function() {
               $.isFunction(callback) && callback();
            });
			     $(icon).removeClass(toggleIconClassLeft).addClass(toggleIconClassRight);
            if (action=="push" && !overridePush) {
              $(opts.targetNode).animate({"margin-right":width},animateSpeed);
            }
          } else {
          $(this.internalContainer).animate({left:0},animateSpeed,function() {
              $.isFunction(callback) && callback();
          });
			    $(icon).removeClass(toggleIconClassRight).addClass(toggleIconClassLeft);
          if (action=="push" && !overridePush) {
            $(opts.targetNode).animate({"margin-left":width},animateSpeed);
          }
          }
          $(this.internalContainer).attr("is-open","true");
        },
        close : function () {
          var opts=this.options;
          var position=(opts.position=="right") ? "right" : "left";
          var width=opts.width;
          var action=opts.action;
		      var icon = $(this.internalContainer).find("span.jq-slide-out-panel-toggle-icon");
          var callback=opts.sliderClosedCallback;
		      var animateSpeed=opts.animateSpeed;
          var toggleIconClassLeft=opts.toggleIconClassLeft;
          var toggleIconClassRight=opts.toggleIconClassRight;
          var overridePush = ($("body").width()<1000) ? true : false;
		    
          if (position=="right") {
            $(this.internalContainer).animate({right:"-"+width},animateSpeed,function() {
               $.isFunction(callback) && callback();
            });
			      $(icon).removeClass(toggleIconClassRight).addClass(toggleIconClassLeft);
            $(opts.targetNode).animate({"margin-right":0},animateSpeed);
          } 
          else {
            $(this.internalContainer).animate({left:"-"+width},animateSpeed,function() {
               $.isFunction(callback) && callback();
            });
  			    $(icon).removeClass(toggleIconClassLeft).addClass(toggleIconClassRight);
            $(opts.targetNode).animate({"margin-left":0},animateSpeed);
          }
          $(this.internalContainer).attr("is-open","false");

          this.removeModalMask();
        },
        showToggle : function () {
          $(this.toggle).show();
        },
        hideToggle : function () {
          $(this.toggle).hide();
        },
        showCloseIcon : function () {
          $(this.closeIconContainer).show();
        },
        hideCloseIcon : function () {
          $(this.closeIconContainer).hide();
        },
        setAction : function (actionType) {
          if (actionType && (actionType==="push" || actionType==="overlay")) {
            this.options.action=actionType;
          }
        }
    }

    // jQuery plugin interface
    $.fn.jqSlideOutPanel = function(opt) {
        // slice arguments to leave only arguments after function name
        var args = Array.prototype.slice.call(arguments, 1);
        return this.each(function() {
            var item = $(this);
            var instance = item.data('JQSlideOutPanel');
            if(!instance) {
                // create plugin instance and save it in data
                item.data('JQSlideOutPanel', new JQSlideOutPanel(this, opt));
            } else {
                // if instance already created call method
                if(typeof opt === 'string') {
                    instance[opt].apply(instance, args);
                }
            }
        });
    }

}(jQuery));
