_            = require 'underscore'
Backbone     = require 'backbone'
Raion        = require '../utils/raion'

route =
  routes:
    'truyen/the-loai/:genre': 'genre'
    'truyen/:slug(/:page)'  : 'story'
    'truyen'                : 'stories'
    ''                      : 'index'

  initialize: ->
    self = @

    # Routes that have RegExp
    @route /truyen\/(.*)\/chuong-([0-9]+)-?(.*?)$/i, 'chapter'

    # When main view is changed
    @on 'main:changed', (view) ->
      view.setElement $('main')
      .render()

  chapter: (slug, number, name) ->
    self = @

    require.ensure [
      '../models/story'
      '../models/chapter'
      '../views/chapter/'
    ], (require) ->
      Story       = require '../models/story'
      Chapter     = require '../models/chapter'
      ChapterView = require '../views/chapter/'

      # ID lookup in cache
      story = new Story slug: slug
      story.fetch()
      .done ->
        sid = story.get '_id'
        _id = Raion.Getter.chapter sid, number
        if _id?
          model = new Chapter _id: _id
        else
          # @todo: Implement backward compability with AJAX request
          model = new Chapter
            sid: sid
            number: number

        model.fetch()
        .done ->
          view = new ChapterView
            model: model
            story: story
          self.trigger 'main:changed', view

  story: (slug, page = 1) ->
    self = @

    require.ensure [
      '../models/story'
      '../views/story/'
    ], (require) ->
      Story     = require '../models/story'
      StoryView = require '../views/story/'

      model = new Story slug: slug
      model.fetch()
      .done ->
        model.get 'chapters'
        .fetch data: page: page
        .done ->
          view = new StoryView model: model
          self.trigger 'main:changed', view

  stories: ->
    self = @

    require.ensure ['../views/stories/'], (require) ->
      StoriesView  = require '../views/stories/'
      view = new StoriesView
      self.trigger 'main:changed', view

  index: ->
    self = @

    require.ensure ['../views/index/'], (require) ->
      HomepageView = require '../views/index/'
      view = new HomepageView
      self.trigger 'main:changed', view

module.exports = Backbone.Router.extend route
