express = require 'express'
routes = express.Router()

Chapter = require '../../models/chapter'

routes.get '/:id', (req, res, next) ->
  Chapter.findOne()
  .where('_id').equals req.params.id
  .exec()
  .then (chapter) ->
    unless chapter?
      res.status 404
      .json message: 'Cannot find chapter with that ID'
    else
      res.json chapter
  , (err) ->
    switch err.name
      when 'CastError' then msg = 'Invalid chapter ID'
      else msg = 'Server error'

    res.status 500
    .json message: msg


module.exports = routes
