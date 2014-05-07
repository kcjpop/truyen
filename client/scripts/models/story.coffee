Base     = require './base'
Raion    = require '../utils/raion'
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

  parse: (data, opt) ->
    # Put this to Raion
    Raion.Setter.story data
    return data


module.exports = Base.extend model
