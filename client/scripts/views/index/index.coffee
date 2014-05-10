Base        = require '../base'
LatestView  = require './latest'
HottestView = require './hottest'
Stories     = require '../../collections/stories'
tpl         = require 'raw!../../tpl/index'

#
# Index view will create 2 sub-views: latest and most viewed
view =
  initialize: ->
    @tpl = @hogan.compile tpl


    col = new Stories
    col.url = app.apiUrl + '/stories?filter=latest'
    @latest = new LatestView collection: col

    col = new Stories
    col.url = app.apiUrl + '/stories?filter=hottest'
    @hottest = new HottestView collection: col

  render: ->
    @$el.html @tpl.render()

    @assign '.hottest', @hottest
    @assign '.latest', @latest
    return @

module.exports = Base.extend view
