Base = require '../base'
tpl  = require 'raw!../../../../app/views/chapter.html'

view =
  initialize: ->
    @tpl = @hogan.compile tpl

  render: ->
    @$el.html @tpl.render chapter: @model.toJSON()
    return @

module.exports = Base.extend view
