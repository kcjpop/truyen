tpl      = require 'raw!../../tpl/stories'
Base     = require '../base'
ListView = require './list'

view =
  initialize: (opt) ->
    @tpl = @hogan.compile tpl
    @list = new ListView collection: opt.stories

  render: ->
    @$el.html @tpl.render()
    @assign '.stories', @list
    return @

module.exports = Base.extend view
