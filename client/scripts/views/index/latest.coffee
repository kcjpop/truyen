Base = require '../base'
tpl  = require 'raw!../../tpl/index/latest'

view =
  initialize: ->
    @tpl = @hogan.compile tpl

  render: ->
    self = @
    @collection.fetch()
    .done ->
      self.$el.html self.tpl.render stories: self.collection.toJSON()

    return @

module.exports = Base.extend view
