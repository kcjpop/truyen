B       = require './base'
Chapter = require '../models/chapter'

col =
  model: Chapter

  parse: (res, opt) ->
    @paging = res.paging if res.paging?
    return res.data

module.exports = B.extend col
