require "./materialize.config.styl"

createView = require "ceri-dev-server/lib/createView"
module.exports = createView
  mixins: [
    require("../src/mixin.coffee")(require("../src/materialize.coffee"))
    require("ceri/lib/style")
  ]
  structure: template 1, """
    <button class=btn @click=toast>Toast</button>
    <br> <br>
    <button class=btn @click=rounded>Rounded</button>
  """
  initStyle:
    display: "block"
    margin: "20px auto"
    width: "108px"
  data: ->
    clicks: 0
  methods:
    toast: -> 
      @$toast text: "click: #{@clicks++}"
    rounded: ->
      @$toast text: "click: #{@clicks++}", class: rounded: true
  tests: ceriToaster: ->
    it "should work", =>
      should.exist @
