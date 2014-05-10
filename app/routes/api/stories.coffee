express = require 'express'
routes  = express.Router()
Story   = require '../../models/story'
Counter = require '../..//models/counter'
moment  = require 'moment'

##
# Define chapters as sub-resource
##
routes.use '/:slug/chapters', require './stories.chapters'

##
# Get story by slug
##
routes.param 'slug', (req, res, next, slug) ->
  Story.findOne slug: slug
  .select '-__v'
  .exec()
  .then (story) ->
    unless story?
      res.status 404
      .json message: 'Cannot find story with this ID'
    else
      req.story = story
    next()
  , (err) ->
    next err

##
# Get all stories
##
routes.get '/', (req, res, next) ->
  registry =
    'latest': Story.latest req.query
    'hottest': Counter.topViewedStories moment()
    'all': Story.all req.query

  method = if req.query.filter? then req.query.filter else 'all'
  unless registry[method]?
    res.status 400
    .json message: 'Invalid filter'
  else
    registry[method]
    .then (stories) ->
      res.json stories

##
# Get a single story
##
routes.get '/:slug', (req, res, next) ->
  res.json req.story

module.exports = routes
