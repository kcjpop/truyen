Base         = require '../base'
tpl          = require 'raw!../../../../app/views/story.html'
ChaptersView = require './chapters'

view =
  initialize: ->
    @template = @hogan.compile tpl
    @chapters = new ChaptersView
      story: @model
      collection: @model.get 'chapters'

    @chapters.on 'page:changed', (currentPage) =>
      url = '/truyen/'+@model.get('slug')+'/'+currentPage
      app.router.navigate url, replace: true

  render: ->
    # Render the main view hoho
    @$el.html @template.render story: @model.attributes
    @assign '#chapters-wrapper', @chapters

    return @

module.exports = Base.extend view
