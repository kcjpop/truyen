gulp       = require 'gulp'
mocha      = require 'gulp-mocha'
coffeelint = require 'gulp-coffeelint'

gulp.task 'default', ->
  console.log 'Default task is running...'

gulp.task 'test', ->
  gulp.src './test/**/*.coffee'
  .pipe mocha
    ui: 'bdd'
    reporters: 'list'

# Watch all CoffeeScript files
gulp.task 'watch', ->
  watcher = gulp.watch './app/**/*.coffee'
  watcher.on 'change', (e) ->
    gulp.src e.path
    .pipe coffeelint()
    .pipe coffeelint.reporter()

  gulp.watch './test/**/*.coffee', ['test']
