Backbone   = require 'backbone'
LatestView = require './latest.coffee'

#
# Index view will create 2 sub-views: latest and most viewed
view =
  initialize: ->
    @latestView = new LatestView el: document.getElementById 'latest'

    @listenTo @latestView, 'story:click', (e) =>
      @trigger 'story:click', e

module.exports = Backbone.View.extend view
