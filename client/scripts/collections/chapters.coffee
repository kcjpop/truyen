B       = require './base'
Chapter = require '../models/chapter'

col =
  model: Chapter

  pushToCache: (items) ->
    app.cache.chapters = app.cache.chapters || {}
    push = (item) ->
      key   = item.sid+'-'+item.number
      value = item._id
      app.cache.chapters[key] = value

    push item for item in items

  parse: (res, opt) ->
    @paging = res.paging if res.paging?
    @pushToCache res.data
    return res.data

  nextPage: ->
    return unless @paging.next?
    @url = app.apiUrl + @paging.next
    @fetch reset: true

  previousPage: ->
    return unless @paging.previous?
    @url = app.apiUrl + @paging.previous
    @fetch reset: true

module.exports = B.extend col
