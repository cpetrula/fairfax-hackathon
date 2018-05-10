<location1>
    <input type="search" name="location1" placeholder="Province/State" class="form-control" ref="input"/>

    <script>
        this.on('mount', () => {
            console.log("Autodetecting state/provice based on network properties");
            fetch('https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyC5oLwQ4kz0841rw4rk-5foOJeCdIiaNQM', {
                method: 'POST',
                headers: {
                    "Content-Type": "application.json"
                },
                body: '{}'
            }).then((resp) => {
                if (!resp.ok) {
                    console.log(resp, resp.json());
                    throw new Error("Bad response status while fetching geolocation");
                }
                return resp.json();
            }).then((geoLocation) => {
                console.log(geoLocation);
                var loc = geoLocation.location;
                return fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${loc.lat},${loc.lng}&key=AIzaSyC5oLwQ4kz0841rw4rk-5foOJeCdIiaNQM`)
            }).then((resp) => {
                if (!resp.ok) {
                    console.log(resp, resp.json());
                    throw new Error("Bad response status while fetching state/province")
                }
                return resp.json();
            }).then((location) => {
                console.log("Automagicked location", location);

                var city = location.results[location.results.length - 2];
                this.placeId = city.place_id;
                this.refs.input.value = city.formatted_address;
            }).catch((err) => {
                console.log(err);
                alert(err);
            })
        });
    </script>
</location1>
<location-select>
    <select name={name} class="form-control" ref="select">
        <option>Province</option>
        <option value="ON">Ontario</option>
        <option value="QC">Quebec</option>
        <option value="BC">British Columbia</option>
        <option value="AB">Alberta</option>
        <option value="MB">Manitoba</option>
        <option value="SK">Sasketchewan</option>
        <option value="NS">Nova Scotia</option>
        <option value="NB">New Brunswick</option>
        <option value="NL">Newfoundland and Labrador</option>
        <option value="PE">Prince Edward Island</option>
        <option value="NT">Northwest Territories</option>
        <option value="YT">Yukon</option>
        <option value="NU">Nanavut</option>
    </select>

    <script>
        this.placeId = null;
        this.name = opts.name || "noname";

        this.on('mount', () => {
            if (!window.sol) {
                window.sol = {};
            }
            var location = window.sol.location;
            if (location) {
                console.log("Location already cached", location);
                this.refs.select.value = location;
                return;
            }

            console.log("Trying to automagick location");
            fetch('https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSyC5oLwQ4kz0841rw4rk-5foOJeCdIiaNQM', {
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
                    console.log(city);
                    this.refs.select.value = city;
                })
                .catch((err) => {
                    console.log(err);
                    alert(err);
                })
        })
    </script>
</location-select>
