<buy-now>
    <br/>
    <div class="container">
        <div class="row">
            <div class="card">
                <div class="card-header">Quote</div>
                <div class="card-body">
                    <p class="price"><span>{formatMoney(price)}</span></p>
                    <table>
                        <tr if={cgl > 0}>
                            <td>General Liability:</td>
                            <td>{formatMoney(cgl)}</td>
                        </tr>
                        <tr if={content > 0}>
                            <td>Business Content:</td>
                            <td>{formatMoney(content)}</td>
                        </tr>
                        <tr if={tools > 0}>
                            <td>Value of Tools & Equipment:</td>
                            <td>{formatMoney(tools)}</td>
                        </tr>
                        <tr if={interruption > 0}>
                            <td>Business Interruption:</td>
                            <td>{formatMoney(interruption)}</td>
                        </tr>
                        <tr if={data > 0}>
                            <td>Cyber Risk & Data Breach:</td>
                            <td>Yes</td>
                        </tr>
                        <tr if={installation > 0}>
                            <td>Installation Liability</td>
                            <td>Yes</td>
                        </tr>
                        <tr if={error > 0}>
                            <td>Personal Errors</td>
                            <td>Yes</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="card">
                <div class="card-header">Business Address</div>
                <div class="card-body">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Business Name</label>
                            <input class="form-control" type="text" placeholder="Mike's Coffee Shop" onchange={onBizAddrChanged} oninput={onBizAddrChanged}/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Address</label>
                            <input class="form-control" type="text" placeholder="1234 Main St" ref="biz-addr" onchange={onBizAddrChanged}  oninput={onBizAddrChanged}/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Address 2</label>
                            <input class="form-control" type="text" placeholder="Apartment, studio, or floor" ref="biz-addr-2" onchange={onBizAddrChanged}  oninput={onBizAddrChanged}/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>City</label>
                            <input class="form-control" type="text" ref="biz-city" onchange={onBizAddrChanged}  oninput={onBizAddrChanged}/>
                        </div>
                        <div class="form-group col-md-4">
                            <label>Province</label>
                            <select class="form-control" ref="biz-state" onchange={onBizAddrChanged}  oninput={onBizAddrChanged}>
                                <option>Choose</option>
                                <option>Ontario</option>
                                <option>Quebec</option>
                                <option>Nova Scotia</option>
                                <option>New Brunswick</option>
                                <option>Manitoba</option>
                                <option>British Columbia</option>
                                <option>Prince Edward Island</option>
                                <option>Saskatchewan</option>
                                <option>Alberta</option>
                                <option>Newfoundland & Labrador</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <label>Zip</label>
                            <input class="form-control" type="text" ref="biz-zip" onchange={onBizAddrChanged}  oninput={onBizAddrChanged}/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="card">
                <div class="card-header">Billing Address</div>
                <div class="card-body">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="billingAddressSame" ref="billAddrSame" onchange={onBillingAddressSame}/>
                        <label class="form-check-label" for="billingAddressSame">Same as business address</label>
                    </div>
                    <div class="row">&nbsp;</div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Name</label>
                            <input class="form-control" type="text" placeholder="John Snow" ref="per-name"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Address</label>
                            <input class="form-control" type="text" placeholder="1234 Main St" ref="per-addr"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Address 2</label>
                            <input class="form-control" type="text" placeholder="Apartment, studio, or floor" ref="per-addr-2"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>City</label>
                            <input class="form-control" type="text" ref="per-city"/>
                        </div>
                        <div class="form-group col-md-4">
                            <label>Province</label>
                            <select class="form-control" ref="per-state">
                                <option>Choose</option>
                                <option>Ontario</option>
                                <option>Quebec</option>
                                <option>Nova Scotia</option>
                                <option>New Brunswick</option>
                                <option>Manitoba</option>
                                <option>British Columbia</option>
                                <option>Prince Edward Island</option>
                                <option>Saskatchewan</option>
                                <option>Alberta</option>
                                <option>Newfoundland & Labrador</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <label>Zip</label>
                            <input class="form-control" type="text" ref="per-zip"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="card">
                <div class="card-header">Payment Details</div>
                <div class="card-body">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label>Card Number</label>
                            <input class="form-control" type="text" >
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-sm-8">
                            <label>Expiration Date</label>
                            <div class="form-row">
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" placeholder="YY">
                                </div>
                                <div class="col-sm-4">
                                    <input type="number" class="form-control" placeholder="MM">
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label>CV Code</label>
                            <input type="number" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="row justify-content-center">
            <button type="submit" class="btn btn-primary btn-big">Buy Now</button>
        </div>
    </div>
    <style>
        p.price {
            text-align: center;
            position: relative;
        }
        p.price > span {
            color: green;
            font-weight: bold;
            font-size: 2em;
        }
        p.price > span::after {
            display: inline;
            font-style: italic;
            color: #00000099;
            font-size: 12px;
            font-weight: normal;
            content: "per month";
            position: absolute;
            bottom: 5px;
        }
        td:first-child {
            padding-right: 1em;
        }
        td:last-child {
            font-style: italic;
            color: #00000099;
        }
    </style>
    <script>

        function getQueryParam(name) {
            var match = RegExp(`[&]?${name}=([^&]*)`).exec(window.location.search);
            return match && match[1];
        }

        this.price = opts.price || getQueryParam("PRICE") || 0;
        this.cgl = opts.cgl || getQueryParam("CGL") || 0;
        this.content = opts.content || getQueryParam("CONTENT") || 0;
        this.tools = opts.tools || getQueryParam("TOOLS") || 0;
        this.data = opts["data"] || getQueryParam("DATA") || 0;
        this.installation = opts.installation || getQueryParam("INSTALLATION") || 0;
        this.errors = opts.errors || getQueryParam("ERRORS") || 0;
        this.interruption = opts.interruption || getQueryParam("INTERRUPTION") || 0;

        this.bizAddr1 = null;


        formatMoney(money) {
            return "$" + money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }


        // Bias the autocomplete object to the user's geographical location,
        // as supplied by the browser's 'navigator.geolocation' object.
        geolocate() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var geolocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    var circle = new google.maps.Circle({
                        center: geolocation,
                        radius: position.coords.accuracy
                    });
                    this.bizAddr1.setBounds(circle.getBounds());
                });
            }
        }

        this.on('mount', () => {
            setTimeout(() => {

                var ac = new google.maps.places.Autocomplete(this.refs["biz-addr"], {types: ['geocode']});
                ac.addListener('place_changed', () => {
                    this.addressChanged();
                });

                this.bizAddr1 = ac;
                this.geolocate();
            }, 1000);
        });

        getAddrComp(place, type, which) {
            var comp = place.address_components.find((comp) => {
                return comp.types[0] === type;
            })

            return ((comp || {})[which]) || "";
        }

        addressChanged() {
            var place = this.bizAddr1.getPlace();
            var streetNumber = this.getAddrComp(place, "street_number", "long_name");
            var street = this.getAddrComp(place, "route", "long_name");
            var city = this.getAddrComp(place, "locality", "long_name");
            var state = this.getAddrComp(place, "administrative_area_level_1", "long_name");
            var zip = this.getAddrComp(place, "postal_code", "short_name");

            this.refs["biz-addr"].value = `${streetNumber} ${street}`
            this.refs["biz-city"].value = city;
            this.refs["biz-state"].value = state;
            this.refs["biz-zip"].value = zip;

            this.onBizAddrChanged({});
        }

        onBizAddrChanged(evt) {
            evt.preventUpdate = true;
            if (this.refs.billAddrSame.checked) {
                this.copyBillingAddress();
            }
        }

        copyBillingAddress() {

            this.refs["per-addr"].value = this.refs["biz-addr"].value;
            this.refs["per-addr-2"].value = this.refs["biz-addr-2"].value;
            this.refs["per-city"].value = this.refs["biz-city"].value;
            this.refs["per-state"].value = this.refs["biz-state"].value;
            this.refs["per-zip"].value = this.refs["biz-zip"].value;
        }

        //could be done better through riotjs, but just getting stuff done right now
        onBillingAddressSame(evt) {
            var isSame = this.refs.billAddrSame.checked;
            if (isSame) {
                this.refs["per-addr"].setAttribute("readonly", "true");
                this.refs["per-addr-2"].setAttribute("readonly", "true");
                this.refs["per-city"].setAttribute("readonly", "true");
                this.refs["per-state"].setAttribute("readonly", "true");
                this.refs["per-zip"].setAttribute("readonly", "true");

                this.copyBillingAddress();
            } else {
                this.refs["per-addr"].removeAttribute("readonly");
                this.refs["per-addr-2"].removeAttribute("readonly");
                this.refs["per-city"].removeAttribute("readonly");
                this.refs["per-state"].removeAttribute("readonly");
                this.refs["per-zip"].removeAttribute("readonly");
            }
        }

    </script>
</buy-now>