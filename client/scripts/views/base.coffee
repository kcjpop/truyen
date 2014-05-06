Backbone = require 'backbone'
Hogan    = require 'hogan'

view =
  hogan: Hogan

  constructor: ->
    Backbone.View.apply @, arguments
    return @

  # Using setElement to assign view to specific position while retaining
  # event handlers
  assign: (selector, view) ->
    view.setElement @$el.find(selector)
    .render()

module.exports = Backbone.View.extend view
