Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/stories.html'

view =
  initialize: ->
    @template = Hogan.compile tpl

  render: ->
    @$el.html @template.render stories: @collection.toJSON()
    @trigger 'rendered'
    return @

module.exports = Backbone.View.extend view
