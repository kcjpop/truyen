Story   = require '../models/story'
Counter = require '../models/counter'
moment  = require 'moment'

module.exports = (app) ->
  # Get all genres of stories
  Story.genres()
  .then (genres) ->
    app.locals.storyGenres = genres

  # Get top-viewed in the current week
  Counter.topViewedStories moment()
  .then (stories) ->
    app.locals.topStories = stories

  app.get '/', (req, res, next) ->
    res.locals =
      title: 'azTruyen, truyện gì cũng có, update nhanh nhất'
    res.render 'index'
