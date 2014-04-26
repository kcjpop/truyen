mongoose = require 'mongoose'
mongoose.connect 'mongodb://127.0.0.1/truyen'
db = mongoose.connection

Story   = require '../models/story'
Chapter = require '../models/chapter'
Counter = require '../models/counter'

stories = require './stories.json'
chapters = require './chapters.json'
counters = require './counters.json'

db.on 'connected', ->
  # Should I empty all collections first?
  stories.forEach (item) ->
    obj = new Story item
    obj.save()

  chapters.forEach (item) ->
    obj = new Chapter item
    item.content.replace /<span(.*)<\/span>/gi, ''
    obj.save()

  counters.forEach (item) ->
    obj = new Counter item
    obj.save()

  console.log 'Done'
