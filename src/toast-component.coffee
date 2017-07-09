module.exports =
  mixins: [
    require "ceri/lib/animate"
    require "ceri/lib/structure"
    require "ceri/lib/style"
    require "ceri/lib/class"
    require "ceri/lib/draghandle"
    require "ceri/lib/util"
    require "ceri/lib/events"
  ]

  structure: template 1, """
    <span :text=toast.text>
    </span>
  """
  events:
    mouseenter: 
      dyn: true
      cbs: "toast.removeTimeout"
    mouseleave:
      dyn: true 
      cbs:"toast.setTimeout"
  computedStyle: 
    this: ->
      zIndex: @toast.zIndex
  data: ->
    toast: {}
  draghandle:
    this:
      initStyle:
        position: "absolute"
        top: 0
        bottom: 0
        left: 0
        right: 0
      style: ->
        zIndex: @toast.zIndex+1
      onClick: -> @toast.close()
      onFirstMove: -> @toast.removeTimeout()
      onMove: (delta, o) ->
        move = 3 * delta.x
        if move > @offsetWidth
          move = @offsetWidth
        else if move < -@offsetWidth
          move = -@offsetWidth
        o.move = move
        @move(o)

      onEnd: (delta, o) ->
        if o.move != -@offsetWidth and o.move != @offsetWidth
          @$cancelLastandAnimate @unMove(o)
          @toast.setTimeout()
        else
          @endMove(o)
          @toast.close(true)

  connectedCallback: ->
    unless @toast.entered
      @toast.entered = true
      @$cancelLastandAnimate @util.assign {el: @},@enter
      @toast._close = (cb) =>
        @$cancelLastandAnimate @util.assign {el: @}, @leave,
            done: =>
              @toast.onClose()
              @toast.entered = false
              cb()