express = require 'express'
app     = express()
port    = process.env.PORT || 3333

# Some settings
app.set 'view engine', 'html'            # To use .html extention for templates
app.set 'views', __dirname+'/app/views'  # Set `views` folder
app.set 'layout', 'layout/master'
app.set 'partials',
    header: 'partials/header'
    head  : 'partials/head'
    js    : 'partials/js'
    footer: 'partials/footer'
app.engine 'html', require 'hogan-express'
app.use express.static __dirname+'/public'

# Set categories
app.locals.categories = [
    {name: 'Kiếm Hiệp'}
    {name: 'Tiên Hiệp'}
    {name: 'Sắc Hiệp'}
    {name: 'Huyền Huyễn'}
    {name: 'Đô Thị'}
    {name: 'Dị Giới'}
    {name: 'Ngôn Tình'}
]

# Set up routes
app.use '/api/v1/stories', require './app/routes/stories'
app.use '/api/v1/stories/:storyId/chapters', require './app/routes/stories.chapters'
app.use '/api/v1/chapters', require './app/routes/chapters'

# Homepage
app.get '/', (req, res, next) ->
    res.locals =
        title: 'Welcome to azTruyen'

    res.render 'index'

app.listen port
console.log 'Server is now running at port '+port;