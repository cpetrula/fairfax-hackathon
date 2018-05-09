<range-slider>
    <div>

        <div if="{this.isBoolean()}">
            <label>
                {label}
            </label>
            <br/>
            <label>
                Yes&nbsp;
                <input type="radio" ref="yes" name={name} value="true" />
            </label>&nbsp;&nbsp;
            <label>
                No&nbsp;
                <input type="radio" ref="no" name={name}  value="no" />
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
        this.ion = null;


        this.on('mount', () => {
            this.initBoolean();

            window.temp1 = this;
        });

        this.on('update', () => {
            this.initBoolean();
        });

        initBoolean() {
            if (!this.isBoolean()) {
                console.log("init ion");
                if (this.ion) {
                    this.ion.data("ionRangeSlider").destroy();
                }
                if ($(this.refs.input).data("ionRangeSlider")) {
                    $(this.refs.input).data("ionRangeSlider").destroy();
                }
                this.ion = $(this.refs.input).ionRangeSlider({
                    type: "single",
                    grid: true,
                    values: this.coverages,
                    prefix: "$",
                    keyboard: true
                });
            }
        }

        isBoolean() {
            return this.coverages.length === 2 && this.coverages[1] === 1;
        }
    </script>
</range-slider>