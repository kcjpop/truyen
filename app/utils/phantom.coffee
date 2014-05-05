# Usage:
#
# phantom.crawl 'http://truyenyy.com/doc-truyen/yeu-nghiet/chuong-1/', ->
#   document.querySelector('div[data-ng-bind-html-unsafe="noidung"]').innerHTML
# .then (result) ->
#   console.log result
Q       = require 'q'
phantom = require 'phantom'

crawl = (url, evaluateCb) ->
  instance = null
  create = ->
    deferred = Q.defer()
    port = Math.floor Math.random() * (40000 - 12300) + 12300
    phantom.create '--load-images=no', port: port, deferred.resolve
    deferred.promise

  create()
  .then (ph) ->
    instance = ph
    deferred = Q.defer()
    ph.createPage deferred.resolve
    deferred.promise
  .then (page) ->
    deferred = Q.defer()
    page.open url, (status) ->
      if status isnt 'success'
        deferred.reject new Error 'Status: '+status
      else
        deferred.resolve page
    deferred.promise
  .then (page) ->
    deferred = Q.defer()

    zepto = '//cdnjs.cloudflare.com/ajax/libs/zepto/1.0rc1/zepto.min.js'
    page.injectJs zepto

    page.evaluate evaluateCb, (result) ->
      deferred.resolve result
      # Close phantomjs process
      instance.exit()
    deferred.promise

exports.crawl = crawl
