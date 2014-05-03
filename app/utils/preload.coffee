class Preload
  constructor: ->
    @stack = {}

  add: (name, data) ->
    @stack[name] = data

  stringify: ->
    JSON.stringify @stack

preloader = new Preload
module.exports = preloader
