Backbone = require 'backbone'
Hogan    = require 'hogan'

tpl = require 'raw!../../../../app/views/story.html'

view =
  initialize: ->
    @template = Hogan.compile tpl

  render: ->
    @$el.html @template.render story: @model.attributes
    return @

module.exports = Backbone.View.extend view
