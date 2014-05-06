B       = require './base'
Chapter = require '../models/chapter'

col =
  model: Chapter

  parse: (res, opt) ->
    @paging = res.paging if res.paging?
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
