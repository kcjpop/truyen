_            = require 'underscore'
Backbone     = require 'backbone'
Raion        = require '../utils/raion'
Story        = require '../models/story'
Chapter      = require '../models/chapter'
Stories      = require '../collections/stories'
HomepageView = require '../views/index/'
StoryView    = require '../views/story/'
StoriesView  = require '../views/stories/'
ChapterView  = require '../views/chapter/'

route =
  routes:
    'truyen/the-loai/:genre': 'genre'
    'truyen/:slug(/p:page)' : 'story'
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
    sid = Raion.Getter.story slug
    _id = Raion.Getter.chapter sid, number
    if _id?
      model = new Chapter _id: _id
      # @todo: Implement backward compability with AJAX request

    model.fetch()
    .done ->
      view = new ChapterView model: model
      self.trigger 'main:changed', view


  story: (slug, page) ->
    self = @

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
    view = new StoriesView
    self.trigger 'main:changed', view

  index: ->
    self = @
    view = new HomepageView
    self.trigger 'main:changed', view

module.exports = Backbone.Router.extend route
