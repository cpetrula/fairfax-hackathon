<range-slider>
    <div>
        <label>{label}</label>
        <input type="text" ref="input" name={name} value="" />
    </div>


    <script>
        this.label = opts.label || "<nolabel>";
        this.name = opts.name || "";
        this.coverages = opts.coverages || [
            0,
            2000000,
            5000000
        ];
        this.ion = null;


        this.on('mount', () => {
            this.ion = $(this.refs.input).ionRangeSlider({
                type: "single",
                grid: true,
                values: this.coverages,
                prefix: "$",
                keyboard: true
            });
        });
    </script>
</range-slider>