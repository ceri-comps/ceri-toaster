id = 0
getId = -> id++
module.exports =
  mixins: [
    require "ceri/lib/structure"
    require "ceri/lib/props"
    require "ceri/lib/style"
    require "ceri/lib/getViewportSize"
    require "ceri/lib/c-for"
    require "ceri/lib/events"
  ]
  structure: template 1, """
    <c-for names=toast id=id iterate=toasts>
      <template>
        <ceri-toast $toast=toast></ceri-toast>
      </template>
    </c-for>
  """
  props:
    zIndex:
      type: Number
      default: 10000
    timeout:
      type: Number
      default: 2500
  events:
    resize:
      window:
        el: window
        throttled: true
        destroy: true
        cbs: -> @$watch.notify "isTop"
  data: ->
    toasts: []
  computedStyle:
    this: ->
      zIndex: @zIndex
  computed: 
    isTop: ->
      pos = @getBoundingClientRect()
      vpheight = @getViewportSize().height
      return pos.top+pos.height/2 <= vpheight/2
  methods:
    clear: -> @toasts = []
    toast: (o) ->
      o.timeout ?= @timeout
      o.zIndex ?= @zIndex
      o.id = getId()
      o.close = (instant) =>
        o.removeTimeout()
        remove = =>
          if ~(index = @toasts.indexOf o)
            @toasts.splice(index,1)
            @$watch.notify "toasts"
        if instant
          remove()
          o.onClose?()
        else
          o._close(remove)
        
      o.setTimeout = ->
        o.removeTimeout?()
        timeoutObj = setTimeout o.close,o.timeout if o.timeout
        o.removeTimeout = -> 
          if timeoutObj?
            clearTimeout(timeoutObj) 
            timeoutObj = null
      o.setTimeout()
      if @isTop
        @toasts.push o
      else
        @toasts.unshift o
      @$watch.notify "toasts"
      return o
      
