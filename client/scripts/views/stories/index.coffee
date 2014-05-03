Backbone = require 'backbone'
Stories  = require '../../collections/stories'
ListView = require './list'

view =
  initialize: ->
    # TODO: promiseeeeeeeeeeeee
    self = @
    # Get stories from API
    stories = new Stories
    stories.fetch()
    .done ->
      self.list = new ListView
        collection: stories

      self.listenTo self.list, 'rendered', self.render
      self.list.render()

  render: ->
    @$el.append @list.$el.html()
    @trigger 'rendered'
    return @

module.exports = Backbone.View.extend view
