Backbone    = require 'backbone'
LatestView  = require './latest'
HottestView = require './hottest'
Stories     = require '../../collections/stories'
Hogan       = require 'hogan'
tpl         = require 'raw!../../../../app/views/index.html'

#
# Index view will create 2 sub-views: latest and most viewed
view =
  initialize: ->
    @tpl = Hogan.compile tpl

    col = new Stories Preload.latestStories
    @latestView = new LatestView collection: col

    col = new Stories Preload.hottestStories
    @hottestView = new HottestView collection: col
    return @

  render: ->
    self = @
    # Render main view
    @$el.html @tpl.render()
    columns = @$el.find('#columns')

    # Render subviews
    columns.append @latestView.render().$el.html()
    columns.append @hottestView.render().$el.html()

module.exports = Backbone.View.extend view
