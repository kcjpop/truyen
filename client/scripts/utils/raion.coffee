# A simple storage for ID lookup
_ = require 'underscore'

cache = app.cache

push = (name, items, fnKey) ->
  cache[name] =  cache[name] || {}

  # If this is a collection
  if items.models?
    items = items.toJSON()

  # Check if item is an instance of Backbone.Model
  if items.cid?
    # Convert to plain object
    items = [items.toJSON()]

  # If this is not an array but a single object
  if _.isArray(items) isnt true and _.isObject items
    items = [items]

  _.each items, (item) =>
    key = fnKey item
    cache[name][key] = item._id

Setter =
  story: (items) ->
    push 'story', items, (item) -> item.slug
  chapter: (items) ->
    push 'chapter', items, (item) -> item.sid+'-'+item.number

Getter =
  story: (slug) ->
    return cache['story'][slug]
  chapter: (sid, number) ->
    key = sid+'-'+number
    return cache['chapter'][key]

module.exports = {Setter, Getter}
