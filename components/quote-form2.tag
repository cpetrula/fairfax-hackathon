<quote-form2>
        <div class="row">
            <div class="col-md-6">
                <label>Revenue</label>
                <input name="REV" type="text" ref="rev" value="" />
            </div>
            <div class="col-md-6" each="{cov in coverages}">
                <range-slider name={cov.code} coverages={cov.values} label={cov.descr} default_value={cov.default_value}></range-slider>
            </div>
        </div>

    <style>


    </style>
    <script>
        this.coverages = [];
        this.total = 0;

        this.descrMap = {
            "CGL": {"desc":"General Liability","order":1,"default_value":2000000},
            "CONTENT": {"desc":"Business Content","order":2,"default_value":0},
            "TOOLS": {"desc":"Value of Tools & Equipment","order":3,"default_value":0},
            "DATA": {"desc":"Cyber Risk & Data Breach","order":4},
            "INSTALLATION": {"desc":"Installation Liability","order":5}
        };

        this.on('updated', () => {
            //manually bind to input changed events
            console.log("updated");
            this.tags["range-slider"].forEach((slider) => {
                slider.on("input", this.rangeSliderChanged);
            })
        });

        this.on('mount', () => {
					this.params=opts.data.result.parameters;
					
            $(this.refs.rev).ionRangeSlider({
                type: "single",
                grid: true,
                min: 0,
                max: 500000,
                prefix: "$",
                keyboard: true,
								from:200000,
                step: 10000,
                onChange: () => {
                    this.rangeSliderChanged({
                        name: "REV",
                        value: parseInt(this.refs.rev.value)
                    })
                }
            });
					this.doUpdate();
        });

        doUpdate() {
            var primaryName = this.params.business;
            var coverages = getCoveragesForPrimaryName(primaryName);
            if (coverages.length === 0) {
                alert("No coverages for " + primaryName);
                return;
            }
						console.log(coverages)
            coverages.forEach((cov) => {
                cov.descr = this.descrMap[cov.code].desc;
								cov.order = this.descrMap[cov.code].order;
								cov.default_value = this.descrMap[cov.code].default_value || 0;
            });
						
						
            this.coverages = sortByKey(coverages,"order");
						this.update();
        }
			
				function sortByKey(array, key) {
					return array.sort(function(a, b) {
							var x = a[key];
							var y = b[key];

							if (typeof x == "string")
							{
									x = (""+x).toLowerCase(); 
							}
							if (typeof y == "string")
							{
									y = (""+y).toLowerCase();
							}

							return ((x < y) ? -1 : ((x > y) ? 1 : 0));
					});
				}

        rangeSliderChanged(data) {
            // console.log(data);
            var enabledCoverages =
                this.tags["range-slider"]
                    .map((slider) => {
                        return {
                            code: slider.name,
                            coverageAmount: slider.getValue()
                        }
                    }).filter((con) => {
                        console.log(con);
                        return con.coverageAmount > 0 || con.code == "TOOLS" || con.code == "CONTENT"
                    });

            var revenue = parseInt(this.refs.rev.value);

            // console.log(revenue, enabledCoverages);
            var quote = getMonthlyQuote(this.params.business, this.params.Province, revenue, enabledCoverages);
            window.sol.tagIdMap["quote-form"].updatePaymentDisplay(quote);
        }
    </script>
</quote-form2>