Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/index/hottest.html'

view =
  render: ->
    @tpl = Hogan.compile tpl
    @$el.html @tpl.render topStories: @collection.toJSON()
    return @

module.exports = Backbone.View.extend view
