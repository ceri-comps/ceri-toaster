# out: ../mixin.js
mixin = null
toaster = null
module.exports = (theme) ->
  unless mixin
    unless window.customElements.get("ceri-toaster")
      window.customElements.define "ceri-toaster", require("./toaster")(theme)
    unless toaster
      toaster = document.createElement "ceri-toaster"
      document.body.appendChild toaster
    mixin = 
      _name: "toaster"
      _v: 1
      methods:
        $toast: (o) -> 
          o.onClose = =>
            if close and ~(i = @_toasts.indexOf(close))
              @_toasts.splice(i,1)
          toaster.toast(o)
          @_toasts.push o.close
          return o.close
      connectedCallback: ->
        if @_isFirstConnect
          @_toasts = []
      disconnectCallback: ->
        for close in @_toasts
          close(true)
        @_toasts = []
  return mixin