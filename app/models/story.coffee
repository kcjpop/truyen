_       = require 'underscore'
m       = require 'mongoose'
Q       = require 'q'
Chapter = require './chapter'

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

##
# Get the list of latest stories
#
# @param Object opt Including `limit`
##
schema.statics.latest = (opt) ->
  deferred = Q.defer()
  query = @find()

  # Limit the result to 10
  if opt?
    query.limit if opt.limit? then opt.limit else 10

  # Execuse it
  query.exec()
  .then (stories) ->
    # Find the latest chapter of each story
    promises = []
    stories.forEach (story) ->
      promise = Chapter.findOne()
      .where('sid').equals story._id
      .sort '-_id'
      .exec()
      .then (chapter) ->
        story.latestChapter = chapter
        return story
      promises.push Q promise

    Q.all promises
    .then (stories) ->
      deferred.resolve stories

  return deferred.promise

module.exports = m.model 'Story', schema
