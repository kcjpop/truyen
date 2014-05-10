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

# When converting to object and JSON, export virtual properties as well
schema.set 'toObject', virtuals: true
schema.set 'toJSON', virtuals: true

# Define the URL of this schema
schema.virtual('url').get ->
  return '/truyen/' + @slug

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

schema.statics.all = (opt) ->
  query = @find()
  .select if opt.fields? then opt.fields else '-__v'
  .sort if opt.sort? then opt.sort else 'name'
  .limit if opt.limit? then opt.limit else 25
  .skip if opt.skip? then opt.skip else 0

  if opt.genre? and opt.genre.length > 0
    query.where('genres').in [opt.genre]

  return Q query.exec()
##
# Get the list of latest stories
#
# @param Object opt Including `limit`
##
schema.statics.latest = (opt) ->
  deferred = Q.defer()

  opt = opt || {}
  @find()
  .limit 10
  .sort '-added'
  .exec()
  .then (stories) ->
    # Find the latest chapter of each story
    promises = []
    stories.forEach (story) ->
      # Convert to obj
      obj = story.toObject()

      promise = Chapter.findOne
        sid: story._id
      .select '-content'
      .sort '-_id'
      .exec()
      .then (chapter) ->
        # Assign
        obj.latestChapter = chapter
        return obj
      promises.push Q promise

    Q.all promises
    .then (stories) ->
      deferred.resolve stories

  return deferred.promise

##
# Get chapters of a stories
#
# @param Integer skip The number of chapter to skip
##
schema.methods.getChapters = (opt) ->
  query = @model('Chapter').find()

  if opt?
    query.limit if opt.limit? then opt.limit else 50
    query.skip  if opt.skip?  then opt.skip  else 0
    query.select if opt.select? then opt.select else '-_v'

  return query
  .where('sid').equals @_id
  .sort 'number'
  .exec()


module.exports = m.model 'Story', schema
