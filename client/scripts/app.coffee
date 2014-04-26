# CSS
require '!style!css!../styles/main.css'

# JavaScript
$ = require 'jquery'
require 'semantic-ui'

$ ->
  $('.popup').popup()
  $('.ui.dropdown').dropdown()

  $ '.ui.sidebar.chapters'
  .sidebar overlay: true
  .sidebar 'attach events', '.toc'
  .sidebar 'attach events', '.ui.sidebar.chapters .close.button'

  $ '.ui.sidebar.navbar'
  .sidebar overlay: true
  .sidebar 'attach events', '.menu.item'
