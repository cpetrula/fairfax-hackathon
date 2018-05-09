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
        </div>
    </div>

    <style scope>
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
    </style>
</app-header>