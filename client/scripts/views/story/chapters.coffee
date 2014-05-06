Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/story/chapters.html'

view =
  events:
    'click a.pager.previous': 'goPreviousPage'
    'click a.pager.next'    : 'goNextPage'

  initialize: (opt) ->
    @story = opt.story
    @tpl = Hogan.compile tpl

    # If data of the collection changes, re-render
    @collection.on 'reset', @render, @

  render: ->
    data =
      story: @story.toJSON()
      chapters: @collection.toJSON()
      paging: @collection.paging


    @$el.html @tpl.render data
    @trigger 'page:changed', @collection.paging.current
    return @

  goNextPage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.nextPage()
    return @

  goPreviousPage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.previousPage()
    return @

module.exports = Backbone.View.extend view
