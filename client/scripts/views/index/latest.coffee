Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../../../app/views/index/latest.html'

view =
  render: ->
    @tpl = Hogan.compile tpl
    @$el.html @tpl.render latestStories: @collection.toJSON()
    @trigger 'rendered'
    return @

module.exports = Backbone.View.extend view
