# JavaScript
$        = require 'jquery'
Backbone = require 'backbone'
require 'semantic-ui'

require.ensure [
  './routers/app'
  '!style!css!../styles/main.css'
], (require) ->
  # CSS
  require '!style!css!../styles/main.css'

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

    App = require './routers/app'
    app.router = new App()
    Backbone.history.start
      root: '/'
      pushState: true

    # Handle links with pushState
    $(document).on 'click', 'a:not([data-bypass=true])', (e) ->
      href = $(e.currentTarget).attr 'href'

      # Allow shift+click for new tabs, etc.
      if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey
        e.preventDefault()
        # Remove leading slashes and hash bangs (backward compatablility)
        url = href.replace /^\//, ''
        .replace '\#\!\/', ''
        # Instruct Backbone to trigger routing events
        app.router.navigate url, { trigger: true }
      return false
