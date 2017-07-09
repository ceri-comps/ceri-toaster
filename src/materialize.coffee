module.exports =
  toaster: {}
    
  toast:
    data: ->
      enter:
        style:
          opacity: [0,1]
          top: [35,0,"px"]
        duration: 300
      leave:
        style:
          opacity: [1, 0]
        duration: 200
    methods:
      move: (o) ->
        move = o.move
        @style.transform = "translateX(#{move}px)"
        @style.opacity = o.opacity = 1 - Math.abs(move / @offsetWidth)
      unMove: (o) ->
        style:
          translateX: [o.move, 0, "px"]
          opacity: [o.opacity, 1]
      endMove: (o) ->
        @style.transform = ""
    computedClass: 
      this: -> @toast.class || {}