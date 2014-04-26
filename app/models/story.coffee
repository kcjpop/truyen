_ = require 'underscore'
m = require 'mongoose'

schema = m.Schema
  name    : String
  slug    : String
  desc    : String
  author  : String
  aliases : [String] # Other names of this title
  genres  : [String] # Its genres
  status  : String   # Ongoing, completed, dropped
  added   :
    type: Date
    default: Date.now

# Get all categories inside all stories
schema.statics.genres = (cb) ->
  promise = @find()
  .select 'genres'
  .exec()

  promise.then (data) ->
    deferred = new m.Promise

    genres = []
    data.forEach (item) ->
      genres = _.uniq genres.concat item.genres

    # No err is null
    deferred.resolve null, genres

    deferred

module.exports = m.model 'Story', schema
