express = require 'express'
routes = express.Router()

Chapter = require '../../models/chapter'

routes.get '/', (req, res, next) ->
  Chapter.find()
  .where('sid').equals req.story._id
  .sort 'number'
  .exec()
  .then (chapters) ->
    res.json chapters

module.exports = routes
