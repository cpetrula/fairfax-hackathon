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
