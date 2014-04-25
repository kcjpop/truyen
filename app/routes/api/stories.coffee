express = require 'express'
routes = express.Router()

Story = require '../../models/story'

routes.get '/', (req, res, next) ->
  # Return all stories in database
  promise = Story.find()
  .sort 'name'
  .select '-_id -__v'
  .exec()

  # Pagination support
  promise.then (stories) ->
    res.json stories

routes.get '/:slug', (req, res, next) ->
  promise = Story.findOne
    slug: req.params.slug
  .select '-_id -__v'
  .exec()

  promise.then (story) ->
    # If cannot find this story
    if story == null
      res.status 404
      .json
        message: 'Cannot find story with this ID'
    else
      res.json story


module.exports = routes
