Backbone     = require 'backbone'
Hogan        = require 'hogan'
tpl          = require 'raw!../../../../app/views/story.html'
ChaptersView = require './chapters'

view =
  constructor: ->
    Backbone.View.apply @, arguments
    @template = Hogan.compile tpl
    @chapters = new ChaptersView
      story: @model
      collection: @model.get 'chapters'

    return @

  render: ->
    # Render the main view hoho
    @$el.html @template.render story: @model.attributes

    @$el.children('div:last').after @chapters.render().$el.html()
    return @

module.exports = Backbone.View.extend view
