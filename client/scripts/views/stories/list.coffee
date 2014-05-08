Base = require '../base'
tpl  = require 'raw!../../tpl/stories/list.html'

view =
  initialize: ->
    @template = @hogan.compile tpl

  render: ->
    @$el.html @template.render stories: @collection.toJSON()
    return @

module.exports = Base.extend view
