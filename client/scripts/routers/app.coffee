Backbone = require 'backbone'
HomepageView = require '../views/index/index.coffee'

route =
  routes:
    'truyen/:slug': 'story'
    'truyen'      : 'stories'
    ''            : 'index'
  story: (slug) ->
    console.log slug

  stories: ->
    console.log 'A list of stories'

  index: ->
    self = @
    @view = new HomepageView()
    @listenTo @view, 'story:click', (e) ->
      $target = $(e.target)
      self.navigate $target.data('target'), true

module.exports = Backbone.Router.extend route
