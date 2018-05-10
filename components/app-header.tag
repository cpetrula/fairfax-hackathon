<app-header>
    <div class="row">
        <div class="col"><img class="logo" src="images/logo.png"></div>
        <div class="col">
          <!--//
          <span class="fa-layers fa-fw">
            <i class="fas fa-circle" style="color:#e6e6e6"></i>
            <i class="fa-inverse fas fa-microphone" data-fa-transform="shrink-6"></i>
          </span>
          //-->

          <span class="contact-phone">
            <i class="fas fa-phone-volume"></i>
            <a href="tel:18445551212">1.844.555.1212</a>
          </span>
            <div id="voice-indicator-icon" class="voice-indicator-pulse-inactive" data-trigger="manual" data-toggle="tooltip" data-placement="left">
              <span class="fa-layers fa-fw " >
                <i class="fas fa-circle voice-indicator-icon-circle-inactive"></i>
                <i class="fas fa-microphone voice-indicator-icon-mic-inactive" ></i>
              </span>
            </div>
        </div>
    </div>
  <script>
    this.on("mount",function() {
      
            $("#voice-indicator-icon").on("click",function() {
                sol.Voice.changeVoiceActivationStatus();
            });

            $('#voice-indicator-icon').on('shown.bs.tooltip', function () {
                setTimeout(function() {
                    $('#voice-indicator-icon').tooltip("hide");
                },3000);
            })
    })
  
  </script>

    <style>
        .logo {
            width:400px;
        }
        .fa-fw {
            float:right;
            font-size:36pt;
        }
        .contact-phone {
            font-size:18pt;
            float:right;
            margin:20px;
        }
        .contact-phone a {
            color:#6c757d;
        }
			  @media (max-width: 420px) {
					.contact-phone {
						display:none;
					}
					.logo {
						width:300px;
					}
			}
      
  #voice-indicator-icon {
    display: inline-block;
    vertical-align: middle;
    float:right;
    margin-top:20px;
  }

  .voice-indicator-pulse-active {

    position: relative;
    width: 40px;
    height: 40px;
    border: none;
    box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7);
    border-radius: 50%;
    background-color: #dc3545;
    background-size:cover;
    background-repeat: no-repeat;
    cursor: pointer;
    -webkit-animation: pulse 1.25s infinite cubic-bezier(0.66, 0, 0, 1);
    -moz-animation: pulse 1.25s infinite cubic-bezier(0.66, 0, 0, 1);
    -ms-animation: pulse 1.25s infinite cubic-bezier(0.66, 0, 0, 1);
    animation: pulse 1.25s infinite cubic-bezier(0.66, 0, 0, 1);
  }

  .voice-indicator-pulse-inactive {
  -webkit-animation: none;-moz-animation: none;-ms-animation: none;animation: none;
    position: relative;
    width: 40px;
    height: 40px;
    border: none;
    box-shadow: 0 0 0 0 rgba(230, 230, 230, 0.7);
    border-radius: 50%;
    background-color: #e6e6e6;
    background-size:cover;
    background-repeat: no-repeat;
    cursor: pointer;
  }


      

.tooltip.bs-tether-element-attached-right .tooltip-inner::before, .tooltip.tooltip-left .tooltip-inner::before {
    top: 50%;
    right: 0;
    margin-top: -5px;
    content: "";
    border-width: 5px 0 5px 5px;
    border-left-color: #e6e6e6;
}
      .tooltip-inner {
    max-width: 200px;
    padding: 3px 8px;
    color: #666 !important;
    text-align: center;
    background-color: #e6e6e6 !important;
    border-radius: .25rem;
}

  .voice-indicator-pulse-active:hover 
  {
    -webkit-animation: none;-moz-animation: none;-ms-animation: none;animation: none;
  }
  @-webkit-keyframes pulse {to {box-shadow: 0 0 0 9px rgba(40, 157, 204, 0);}}
  @-moz-keyframes pulse {to {box-shadow: 0 0 0 9px rgba(40, 157, 204, 0);}}
  @-ms-keyframes pulse {to {box-shadow: 0 0 0 9px rgba(40, 157, 204, 0);}}
  @keyframes pulse {to {box-shadow: 0 0 0 9px rgba(40, 157, 204, 0);}}

  .fa-layers {
  width:40px;
  height:40px;
  }
  .fa-circle {
  font-size: 24pt;
  color: #dc3545;
  }
  .fa-microphone {
  font-size:18pt;
  }
  .voice-indicator-icon-circle-active {
  color: #dc3545;
  }
  .voice-indicator-icon-circle-inactive {
  color: #e6e6e6;
  }
  .voice-indicator-icon-mic-active {
  color:#fff;
  }
  .voice-indicator-icon-mic-inactive {
  color:#999;
  }
  .voice-indicator-icon-idle {
  -webkit-animation: none !important;
  -moz-animation: none !important;
  -ms-animation: none !important;
  animation: none !important;
  }

    </style>
</app-header>