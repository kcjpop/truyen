_            = require 'underscore'
Backbone     = require 'backbone'
Story        = require '../models/story.coffee'
HomepageView = require '../views/index/index.coffee'
StoryView    = require '../views/story/index.coffee'

route =
  routes:
    'truyen/:slug': 'story'
    'truyen'      : 'stories'
    ''            : 'index'

  initialize: ->
    self = @
    @main = $('main').first()
    # When main view is changed
    @on 'main:changed', (view) ->
      self.main.html view.$el.html()


  story: (slug) ->
    # Find this slug in Preload
    # story = _.findWhere Preload.stories, slug: slug
    # if story?
    #   model = story
    # else
    #   model = new Story

    model = new Story name: "Vợ Ta Là Hoa Hậu Giảng Đường"
    view = new StoryView model: model
    view.render()
    @trigger 'main:changed', view

  stories: ->
    console.log 'A list of stories'

  index: ->
    self = @
    @view = new HomepageView()
    @listenTo @view, 'story:click', (e) ->
      $target = $(e.target)
      self.navigate $target.data('target'), true

module.exports = Backbone.Router.extend route
