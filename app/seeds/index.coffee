mongoose = require 'mongoose'
mongoose.connect 'mongodb://127.0.0.1/truyen'
db = mongoose.connection

Story   = require '../models/story'
Chapter = require '../models/chapter'

stories = require './stories.json'
chapters = require './chapters.json'

db.on 'connected', ->
  # Should I empty all collections first?
  stories.forEach (item) ->
    obj = new Story item
    obj.save()

  chapters.forEach (item) ->
    obj = new Chapter item
    obj.save()
