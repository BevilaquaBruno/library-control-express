createError = require 'http-errors'
express = require 'express'
path = require 'path'
cookieParser = require 'cookie-parser'
logger = require 'morgan'
initCouch = require './init_couch'

initCouch (err) ->
  if err
    console.log err
  else
    console.log 'couchdb initialized'
  return

#require routes
indexRouter = require './routes/index'
booksRouter = require './routes/books'
authorsRouter = require './routes/authors'
genresRouter = require './routes/genres'
app = express()

# view engine setup
app.set 'views', path.join(__dirname,'../views')
app.set 'view engine', 'pug'

app.use logger('dev')
app.use express.json()
app.use express.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

#spectre files
app.use '/spectre', express.static('node_modules/spectre.css/dist')

app.use '/', indexRouter
app.use '/books', booksRouter
app.use '/authors', authorsRouter
app.use '/genres', genresRouter

app.use (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Headers', 'Origin, X-Requested-With', 'Content-Type, Accept'
  next()
  return

#catch 404 and forward to error handler
app.use (req, res, next) ->
  next createError(404)
  return

# error handler
app.use (err, req, res, next) ->
  res.locals.message = err.message
  res.locals.error = if req.app.get('env') == 'development' then err else {}
    # render the error page
  res.status err.status or 500
  res.render 'error'
  return

module.exports = app
