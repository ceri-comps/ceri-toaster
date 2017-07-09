toaster = null
module.exports = (theme) ->
  unless toaster
    toaster = require "./toaster-component"
    toaster.mixins.push theme.toaster
    ceri = require "ceri/lib/wrapper"
    toaster = ceri(toaster)
    unless window.customElements.get("ceri-toast")
      toast = require "./toast-component"
      toast.mixins.push theme.toast 
      window.customElements.define "ceri-toast", ceri(toast)
  return toaster
 
