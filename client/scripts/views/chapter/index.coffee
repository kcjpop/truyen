Base = require '../base'
tpl  = require 'raw!../../../../app/views/chapter.html'

view =
  initialize: (opt) ->
    @story = opt.story
    @tpl = @hogan.compile tpl

  render: ->
    @$el.html @tpl.render
      chapter: @model.toJSON()
      story  : @story.toJSON()

    # Move the scroll bar to top
    $(window).scrollTop 0
    return @

module.exports = Base.extend view
