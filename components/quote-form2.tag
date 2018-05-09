<quote-form2>
    <div class="top-bar"></div>
    <div class="questions-container">
        <h2>Let's get you some options!</h2>
        <p class="help-text">Just start typing or use your voice.</p>
        <input type="text" placeholder="Paste primaryName here" value="Handyman/Handywoman" class="form-control" ref="primaryName"> <button onclick={doUpdate}>Update</button>
    </div>
    <div class="container">

        <div class="row">
            <div class="col-md-6" each="{cov in coverages}">
                <range-slider name={cov.code} coverages={cov.values} label={cov.descr}></range-slider>
            </div>
        </div>
        <div class="row">
            <h3>Total: {total}</h3>
        </div>
    </div>
    <br/>
    <br/>
    <br/>

    <style>
        .top-bar {
            border-top:1px solid #555;
            padding-top:20px;
            margin-top:10px;
            display:none;
        }
        .payment-container {
            position:fixed;
            bottom:0;
            height:60px;
            padding:0 50px;
            width:100%;
            background-color:#e6e6e6;
            display:none;
        }
        #buy-now-btn {
            margin-bottom:10px;
            margin-left:30px;
        }
        .monthly-payment-amount {
            font-size:28pt;
        }
        .calculator-container {
            display:none;
            padding:0 50px;
        }
    </style>
    <script>
        this.coverages = [];
        this.total = 0;

        this.descrMap = {
            "CGL": "General Liability",
            "DATA": "Cyber Risk & Data Breach",
            "CONTENT": "Business Content",
            "INSTALLATION": "Installation Liability",
            "TOOLS": "Tool Liability"
        };

        doUpdate(evt) {
            var primaryName = this.refs.primaryName.value;
            var coverages = getCoveragesForPrimaryName(primaryName);
            if (coverages.length === 0) {
                alert("No coverages for " + primaryName);
                return;
            }

            coverages.forEach((cov) => {
                cov.descr = this.descrMap[cov.code];
            });

            this.coverages = coverages;

            //manually update so that we can register once for events
            evt.preventUpdate = true;
            this.update();

            //manually bind to input changed events
            this.tags["range-slider"].forEach((slider) => {
                slider.on("input", this.rangeSliderChanged);
            })
        }

        rangeSliderChanged(data) {
            console.log(data);
        }
    </script>
</quote-form2>