_            = require 'underscore'
Backbone     = require 'backbone'
Story        = require '../models/story'
Chapter      = require '../models/chapter'
Stories      = require '../collections/stories'
HomepageView = require '../views/index/'
StoryView    = require '../views/story/'
StoriesView  = require '../views/stories/'

route =
  routes:
    'truyen/the-loai/:genre': 'genre'
    'truyen/:slug'          : 'story'
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
    # ID lookup in cache
    # @todo: Implement backward compability
    cache = app.cache.chapters
    key = slug + '-' + number
    if cache[key]?
      model = new Chapter _id: cache[key]

    model.fetch()
    .done ->
      console.log model.toJSON()


  story: (slug) ->
    # Find this slug in Preload
    # story = _.findWhere Preload.stories, slug: slug
    # if story?
    #   model = story
    # else
    #   model = new Story

    self = @
    model = new Story slug: slug
    model.fetch()
    .done ->
      model.get 'chapters'
      .fetch()
      .done ->
        model.pushToCache()
        view = new StoryView model: model
        self.trigger 'main:changed', view

  stories: ->
    self = @
    view = new StoriesView
    self.trigger 'main:changed', view

  index: ->
    self = @
    view = new HomepageView
    self.trigger 'main:changed', view

module.exports = Backbone.Router.extend route
