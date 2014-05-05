Backbone     = require 'backbone'
Hogan        = require 'hogan'
tpl          = require 'raw!../../../../app/views/story.html'
ChaptersView = require './chapters'

view =
  initialize: ->
    @template = Hogan.compile tpl
    @chapters = new ChaptersView
      story: @model
      collection: @model.get 'chapters'

  render: ->
    # Render the main view hoho
    @$el.html @template.render story: @model.attributes

    @chapters.setElement @$el.find('#chapters-wrapper')
    .render()

    return @

module.exports = Backbone.View.extend view
