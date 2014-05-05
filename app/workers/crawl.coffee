Q       = require 'q'
phantom = require '../utils/phantom'

mongoose = require 'mongoose'
mongoose.connect 'mongodb://127.0.0.1:27017/truyen'
Story   = require '../models/story'
Chapter   = require '../models/chapter'
kue = require 'kue'
queue = kue.createQueue()
kue.app.listen 8888
console.log 'Queue monitor starts at 8888'

enqueue = (url, story) ->
  queue.create 'Crawl',
    url: url
    story: story
  .save (err) ->
    msg = 'Job added: '+url
    msg = err if err
    console.log msg

queue.process 'Crawl', 10, (job, done) ->
  crawlChapter job.data.url, job.data.story
  .then ->
    console.log 'Complete crawling'
    done()

slugify = (str) ->
    str.replace /(á|à|ả|ã|ạ|â|ấ|ầ|ẩ|ậ|ă|ằ|ắ|ặ|ẳ|ẵ)/gi, 'a'
    .replace /(é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ệ)/gi, 'e'
    .replace /(ó|ò|ỏ|õ|ọ|ơ|ờ|ớ|ở|ợ|ỡ|ô|ố|ồ|ổ|ộ)/gi, 'o'
    .replace /(í|ì|ỉ|ĩ|ị)/gi, 'i'
    .replace /(ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ự)/gi, 'u'
    .replace /(ý|ỳ|ỷ|ỹ|ỵ)/gi, 'y'
    .replace /(đ)/gi, 'd'
    .toLowerCase()
    .replace /^\s+|\s+$/g, ''
    .replace /(\s)+/g, '-'
    .replace /-+/g, '-'

crawlChapter = (url, story) ->
  deferred = Q.defer()
  console.log 'Now crawling '+url
  phantom.crawl url, ->
    data = {}
    tmp = document.querySelector('#noidungtruyen h1')
    .textContent
    .match /Chương\s([0-9]+):?\s?(.*)/i

    data.number  = +tmp[1]
    data.name    = tmp[2]
    data.content = document.querySelector 'div[data-ng-bind-html-unsafe="noidung"]'
    .innerHTML

    return data
  .then (data) ->
    data.slug = if data.name != '' then slugify data.name else ''
    data.sid = story._id

    Chapter.findOne
      sid: story._id
      number: data.number
    .exec()
    .then (chapter) ->
      unless chapter?
        chapter = new Chapter data
        chapter.save (err, chapter) ->
          deferred.resolve chapter
      else
        deferred.resolve chapter

  return deferred.promise

crawlPage = (url, story) ->
  console.log 'Now crawling '+url
  phantom.crawl url, ->
    links = []
    $('dt:last > ul a').each (i, item) ->
      links.push $(item).prop('href')

    return links
  .then (links) ->
    enqueue link, story for link in links

url = process.argv[1]
phantom.crawl url, ->
  data = {}
  # Get title
  dd = $('.chitiet_truyen').find 'dd'

  data.slug   = document.location.pathname.match(/\/truyen\/(.*)\/$/)[1]
  data.name   = $('h1.ten_truyen').text()
  data.alias  = $(dd[0]).text().split(',').map $.trim
  data.status = $(dd[3]).text().trim()
  data.author = $('span.author').text().replace('Tác Giả: ', '')
  data.desc   = $('blockquote').html()

  data.genres = []
  $(dd[1]).children('span').each (idx, item) ->
    data.genres.push $(item).text()

  _a = $('div.pagination').find 'a'
  page = +$(_a[_a.length - 2]).text()

  return [data, page]
.then (result) ->
  data = result[0]
  page = result[1]
  # Find this story
  Story.findOne slug: data.slug
  .exec()
  .then (story) ->
    unless story?
      console.log 'Create new story'
      story = new Story data
      story.save (err, story) ->
        console.log 'Story saved'

    console.log 'URL has '+page+' pages'

    crawlPage url+'?page='+i, story for i in [1..page]

