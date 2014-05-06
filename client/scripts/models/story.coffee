Base = require './base'
Chapters = require '../collections/chapters'

model =
  urlRoot: app.apiUrl + '/stories'

  idAttribute: 'slug'

  defaults:
    name    : ''
    slug    : ''
    desc    : ''
    author  : ''
    aliases : ''
    genres  : []
    status  : ''
    added   : new Date()

  constructor: ->
    Base.apply @, arguments

    chapters = new Chapters
    chapters.url = @urlRoot + '/' + @id + '/chapters'
    @set 'chapters', chapters

  pushToCache: ->
    self = @

    # global: app
    app.cache = app.cache || {}
    app.cache.chapters = app.cache.chapters || {}

    push = (chapter) ->
      key = self.get('slug') + '-' + chapter.get('number')
      value = chapter.get '_id'
      app.cache.chapters[key] = value

    @get 'chapters'
    .forEach push


module.exports = Base.extend model
