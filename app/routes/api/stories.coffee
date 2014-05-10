express = require 'express'
routes = express.Router()

Story = require '../../models/story'

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
  Story.all req.query
  .then (stories) ->
    res.json stories

##
# Get a single story
##
routes.get '/:slug', (req, res, next) ->
  res.json req.story

module.exports = routes
