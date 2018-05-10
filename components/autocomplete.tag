<autocomplete>
    <div ref="container" onblur={onAllBlur}>
        <input ref="input" type="text"
               placeholder={placeholder} name={name}
               class={form-control: true, focus: shown}
               oninput={onInput} onkeydown={onInputKeyDown}
               onfocus={onInputFocus} onblur={onAnyBlur}/>
        <table show={shown} ref="optionsList" cellspacing="0">
            <tr each="{item in shownItems}" tabindex="0"
                onclick={onItemClicked} onkeydown={onItemKeyDown} onblur={onAnyBlur}>
                <td>
                    <strong>{item.name}</strong>
                    <span if={item.descr}>
                        <br/>
                        <em>{item.descr}</em>
                    </span>
                </td>
            </tr>
            <tr if={shown && shownItems.length == 0}>
                <td>{emptyText}</td>
            </tr>
        </table>
    </div>

    <style>
        /* copied from .form-control:focus */
        .form-control.focus {
            color: #495057;
            background-color: #fff;
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .container {
            position: relative;
        }
        table {
            border-collapse: separate;
            border: 1px solid #aaa;
            border-radius: 3px;
            background: white;
            position: absolute;
            top: 3rem;
            z-index: 99999;
        }
        td {
            padding: 0.25rem 0.5rem;
            border-bottom: 1px solid #aaa;
        }
        tr:last-child > td {
            border-bottom: 0;
        }
        tr:hover, tr:focus {
            background: #eee;
        }
        em {
            font-size: 0.9em;
        }
    </style>

    <script>
        this.placeholder = this.opts.placeholder;
        this.name = this.opts.name || "";
        this.minLength = this.opts.minLength || 2;
        this.emptyText = this.opts.emptyText || "No items matched your search criteria";

        this.items = [];
        this.shownItems = [];
        this.shown = false;

        this.value = "";
        this.valueItem = null;

        //if load new items from remoteUrl
        this.remoteUrl = null;

        this.on('mount', () => {
            if (this.opts.url) {
                this.load(this.opts.url);
            } else if (this.opts.remoteUrl) {
                this.remoteUrl =  this.opts.remoteUrl;
            }
        });

        //load items from a url
        load(url) {
            console.log("Loading", this.name, url)
            fetch(url)
                .then((resp) => {
                    if (!resp.ok) {
                        throw new Error("Bad response " + resp);
                    }
                    return resp.json();
                })
                .then((json) => {
                    console.log("Loaded", this.name, json);
                    this.items = json;
                })
                .catch((err) => {
                    console.log("Error loading", this.name, err);
                    alert(`Error loading ${this.name}! \n\n${err}`);
                });
        }

        onInputFocus(evt) {
            //uncomment this line to show on focus
            // this.shown = this.refs.input.value.length >= this.minLength;
            // console.log("show", this.shown);
        }

        search(text) {
            if (this.remoteUrl) {
                //search via a url
                return fetch(`${this.remoteUrl}${encodeURIComponent(text)}`)
                    .then((resp) => {
                        if (!resp.ok) {
                            console.log(resp);
                        }

                        return resp.json()
                    })
                    .then((json) => {
                        console.log(json);
                        //map json to name/description format

                        var mapped = json.predictions.map((pred) => {
                            return {
                                name: pred.terms[0].value,
                                description: pred.description.substring(pred.terms[1].offset)
                            }
                        })

                        return Promise.resolve(mapped);
                    })



            } else {
                //do a default text search of items
                return Promise.resolve(this.score(text));
            }
        }

        score(text) {
            //todo: use better a text search alg. (order by score, limit results)
            return this.items.filter((item) => {
                var name = item.name.toLowerCase();
                if (name.indexOf(text) !== -1) {
                    return true;
                }

                if (item.synonyms) {
                    return item.synonyms.some((syn) => syn.toLowerCase().indexOf(text) !== -1);
                }

                return false;
            });
        }

        onInput(evt) {
            //save value no matter what
            this.value = this.refs.input.value;

            var text = this.value.toLowerCase();
            if (text.length >= this.minLength) {
                this.search(text)
                    .then((items) => {
                        this.shownItems = items;
                        this.shown = this.value.length >= this.minLength;
                        this.update();
                        // console.log("input", this.value, this.shown, this.shownItems);
                    })
                    .catch((err) => {
                        console.log("Error searching items", err);
                        alert(err);
                    })
            } else {
                this.shown = false;
                this.shownItems = [];
            }

            //update will happen later
            evt.preventUpdate = true;

        }

        selectItem(item) {
             // console.log("select", item);

            this.value = item.name;
            this.valueItem = item;
            this.refs.input.value = item.name;
            this.refs.input.focus();
            this.shownItems = [ item ]; //quick hack
            this.shown = false;
        }

        onItemClicked(evt) {
            this.selectItem(evt.item.item);
        }

        moveFocus(indexItem, offset) {
            var index = this.shownItems.indexOf(indexItem);

            //special case
            if (index === 0 && offset === -1) {
                this.refs.input.focus();
                return;
            }

            var optionList = this.refs.optionsList.tBodies[0];
            var newIndex = index + offset;
            var newItem = optionList.rows[newIndex];
            if (newItem) {
                newItem.focus();
            }

            console.log(indexItem, offset, index, newIndex, optionList, newItem);
        }

        onItemKeyDown(evt) {
            var item = evt.item.item; //why wrapped?

            switch (evt.which) {
                case 13: //13 == ENTER/RETURN key
                    this.selectItem(item);
                    evt.preventDefault();
                    break;
                case 38: //38 == UP_ARROW key
                    this.moveFocus(item, -1); //-1 = "up" one in the list
                    evt.preventDefault();
                    break;
                case 40: //40 == DOWN_ARROW key
                    this.moveFocus(item, 1); //1 = "down" one in the list
                    evt.preventDefault();
                    break;
                case 27: //27 == ESCAPE key
                    this.shown = false;
                    this.refs.input.focus();
                    evt.preventDefault();
                    break;
            }
        }

        onInputKeyDown(evt) {
            switch(evt.which) {
                case 40: //40 == DOWN_ARROW key
                    if (!this.shown) {
                        //do this?
                        // this.shown = true;
                        // this.update();
                    }

                    if (this.shown) {
                        this.refs.optionsList.tBodies[0].rows[0].focus(); //focus first TR
                    }

                    evt.preventDefault();
                    break;
                case 27: //27 == ESCAPE key
                    this.shown = false;
                    evt.preventDefault();
                    break;
                case 8:
                case 13:
                    this.onInput({});
                    break;
            }
        }

        onAnyBlur(evt) {
            setTimeout(() => {
                var focusEl = $(this.refs.container).find(":focus")
                if (focusEl.length === 0) {
                    this.shown = false;
                    this.update();
                }
            }, 15)
        }

    </script>
</autocomplete>