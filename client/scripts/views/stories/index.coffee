Backbone = require 'backbone'
Stories  = require '../../collections/stories'
ListView = require './list'

view =
  render: ->
    # TODO: promiseeeeeeeeeeeee
    self = @
    # Get stories from API
    stories = new Stories
    stories.fetch()
    .done ->
      list = new ListView
        collection: stories

      self.$el.append list.render().$el.html()

    return @

module.exports = Backbone.View.extend view
