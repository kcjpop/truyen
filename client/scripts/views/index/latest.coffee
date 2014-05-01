Backbone = require 'backbone'

view =
  events:
    'click a.story': 'goToStory'

  goToStory: (e) ->
    e.preventDefault()
    @trigger 'story:click', e

module.exports = Backbone.View.extend view
