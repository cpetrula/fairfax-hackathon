<range-slider>
    <div class="range-slider-container">

        <div if="{this.isBoolean()}">
            <label>
                {label}
            </label>
            <br/>
            <label>
                No&nbsp;
                <input type="radio" ref="no" name={name}  value="no" checked onchange={onNo} />
            </label>&nbsp;&nbsp;
            <label>
                Yes&nbsp;
                <input type="radio" ref="yes" name={name} value="true" onchange={onYes}/>
            </label>
        </div>
        <div if="{!this.isBoolean()}">
            <label>
                {label}
            </label>
            <input type="text" ref="input" name={name} value="" />
        </div>
    </div>


    <script>
        this.label = opts.label || "<nolabel>";
        this.name = opts.name || "";
        this.coverages = opts.coverages || [
            0,100,200
        ];
        this.defaultValue = parseInt(opts.default_value) || 0;
        this.ion = null;

        this.on('mount', () => {
            this.initBoolean();
        });

        this.on('update', () => {
            this.initBoolean();
        });

        onYes(evt) {
            evt.preventUpdate = true;

            // console.log("onYes");
            this.trigger('input', {
                name: this.name,
                value: 1
            });
        }

        onNo(evt) {
            evt.preventUpdate = true;

            // console.log("onNo");
            this.trigger('input', {
                name: this.name,
                value: 0
            });
        }

        getValue() {
            return this.isBoolean() ? (this.refs.yes.checked + 0) : parseInt(this.refs.input.value);
        }

        increaseRangeValue(offset) {
            var offset = offset || 1;
            var slider = $(this.ion).data("ionRangeSlider");
            slider.update({
                from: slider.result.from + offset;
            });
        }

        decreaseRangeValue() {
            increaseRangeValue(-1);
        }

        initBoolean() {
            if (!this.isBoolean()) {
                // console.log("init ion");
                if (this.ion) {
                    this.ion.data("ionRangeSlider").destroy();
                }
                if ($(this.refs.input).data("ionRangeSlider")) {
                    $(this.refs.input).data("ionRangeSlider").destroy();
                }
                this.ion = $(this.refs.input).ionRangeSlider({
                    type: "single",
                    grid: true,
                    grid_snap: true,
                    values: this.coverages,
                    from: this.coverages.indexOf(this.defaultValue),
                    prefix: "$",
                    keyboard: true,
                    onChange: () => {
                        var value = this.refs.input.value;
                        // console.log("onChange", value);
                        this.trigger('input', {
                            name: this.name,
                            value: parseInt(value)
                        });
                    }
                });
                console.log({
                    type: "single",
                    grid: true,
                    grid_snap: true,
                    values: this.coverages,
                    from: this.defaultValue,
                    prefix: "$",
                    keyboard: true,
                    onChange: () => {
                        var value = this.refs.input.value;
                        // console.log("onChange", value);
                        this.trigger('input', {
                            name: this.name,
                            value: parseInt(value)
                        });
                    }
                });
            }
        }

        isBoolean() {
            return this.coverages.length === 2 && this.coverages[1] === 1;
        }
    </script>
	<style>
		.range-slider-container {
			margin-bottom:20px;
		}
	</style>
</range-slider>