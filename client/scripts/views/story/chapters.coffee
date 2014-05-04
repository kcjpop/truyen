Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/story/chapters.html'

view =
  constructor: ->
    Backbone.View.apply @, arguments
    @tpl = Hogan.compile tpl
    return @

  render: ->
    data =
      story:
        chapters: @collection.toJSON()

    @$el.html @tpl.render data

    return @

module.exports = Backbone.View.extend view
