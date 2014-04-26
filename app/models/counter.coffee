Q     = require 'q'
m     = require 'mongoose'
Story = require './story'

schema = m.Schema
  year  : Number
  month : Number
  week  : Number
  object: String # Object type, e.g 'chapter'
  oid   : m.Schema.Types.ObjectId # Object ID
  views   : # Number of view
    type: Number
    default: 0

##
# Get list of top viewed stories
# @param Moment the date that is used to match
##
schema.statics.topViewedStories = (date) ->
  deferred = Q.defer()

  @find()
  .where('year').equals date.year()
  .where('month').equals date.month() + 1 # Month in JS is zero-based
  .where('week').equals date.week()
  .sort 'views'
  .exec()
  .then (result) ->
    promises = []
    result.forEach (item) ->
      promise = Story.findOne()
        .where('_id').equals item.oid
        .exec()
        .then (story) ->
          story.views = item.views
          return story
      promises.push Q promise # Convert to Q promise

    Q.all promises
    .then (stories) ->
      deferred.resolve stories

  deferred.promise

module.exports = m.model 'Counter', schema
