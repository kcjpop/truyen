Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/story/chapters.html'

view =
  initialize: (opt) ->
    @story = opt.story
    @tpl = Hogan.compile tpl

  render: ->
    data =
      story: @story.toJSON()
      chapters: @collection.toJSON()
      paging: @collection.paging

    @$el.html @tpl.render data
    return @

module.exports = Backbone.View.extend view
