Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/story/chapters.html'

view =
  constructor: (opt) ->
    Backbone.View.apply @, arguments
    @story = opt.story
    @tpl = Hogan.compile tpl
    return @

  render: ->
    data =
      story: @story.toJSON()
      chapters: @collection.toJSON()

    @$el.html @tpl.render data
    return @

module.exports = Backbone.View.extend view
