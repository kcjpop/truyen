Q = require 'q'
# Config
konfig = require 'konfig'
global.config = konfig path: './app/config'

# Connect to database
mongoose = require 'mongoose'
mongoose.connect global.config.database.url
db = mongoose.connection

Story   = require '../models/story'
Chapter = require '../models/chapter'
Counter = require '../models/counter'

stories = require './stories.json'
chapters = require './chapters.json'
counters = require './counters.json'

promises = []
db.on 'connected', ->

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
