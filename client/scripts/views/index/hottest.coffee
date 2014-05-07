Backbone = require 'backbone'
Hogan    = require 'hogan'
tpl      = require 'raw!../../tpl/index/hottest'

view =
  render: ->
    @tpl = Hogan.compile tpl
    @$el.html @tpl.render topStories: @collection.toJSON()
    return @

module.exports = Backbone.View.extend view
