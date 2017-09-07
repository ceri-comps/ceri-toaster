# ceri-toaster

toasts, quick and easy

### [Demo](https://ceri-comps.github.io/ceri-toaster)

# Install

```sh
npm install --save-dev ceri-toaster
```

## Usage

```coffee
Toaster = require("ceri-toaster")
# load the theme (see below)
window.customElements.define("ceri-toaster", Toaster(require("ceri-toaster/materialize")))
toaster = document.createElement("ceri-toaster")
document.body.appendChild(toaster)
toaster.toast({text:"Hello!", timeout: 5000, onClose: => return})

```

## Mixin

the toaster can be used as a mixin within other ceri components:
```coffee
  ...
  mixins: [
    require("ceri-toaster/mixin")(require("ceri-toaster/materialize"))
  ]
  ...
  methods:
    doSomething: ->
      close = @$toast({text:"Hello!", timeout: 5000})
      close() 
```

## Themes
#### Materialize
- setup [ceri-materialize](https://github.com/ceri-comps/ceri-materialize) and load the scss.
```scss
// and this additional requirement
@import "~ceri-toaster/materialize";
```
- load theme file
```coffee
Toaster = require("ceri-toaster")
window.customElements.define("ceri-toaster", Toaster(require("ceri-toaster/materialize")))
```

For example see [`dev/materialize`](dev/materialize.coffee).


# Development
Clone repository
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## Notable changes
#### 0.2.0
- use ceri-materialize@2


## License
Copyright (c) 2017 Paul Pflugradt
Licensed under the MIT license.
