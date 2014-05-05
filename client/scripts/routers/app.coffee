_            = require 'underscore'
Backbone     = require 'backbone'
Story        = require '../models/story.coffee'
Stories      = require '../collections/stories.coffee'
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
        view = new StoryView model: model
        view.on 'rendered', ->
          self.trigger 'main:changed', view
        view.render()

  stories: ->
    self = @
    view = new StoriesView
    view.on 'rendered', ->
      self.trigger 'main:changed', view

  index: ->
    self = @
    view = new HomepageView
    self.trigger 'main:changed', view

module.exports = Backbone.Router.extend route
