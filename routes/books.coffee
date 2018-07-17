express = require 'express'
router = express.Router()
hash = require 'object-hash'
booksModel = require '../models/booksModel'
timestamp = require 'time-stamp'

# GET home page.asdasd
router.get '/', (req, res) ->
  booksList = booksModel.getAll(true, (err, body) ->
    if err
      show = true
      msg = 'Error on get books'
    if body.rows > 0
      show = true
      msg = 'Error on get books'
    else
      show = false
      msg = 'page open'

    res.render 'books',
    title: 'Books',
    data: body.rows
    message:
      show: show,
      msg:  msg
    return
    )
router.get '/createPage', (req, res) ->
  res.render 'booksCreate',
  title: 'Create a Book',
  message:
    show: false,
    msg:  'page open'
  data:
    book_id: req.book_id || ''
    book_name: req.book_name || ''
  return

router.post '/create', (req, res) ->
  req.body.book_timestamp = timestamp 'YYYYMMDDmmss'
  myHash = hash req.body
  obj = booksModel.create req.body, myHash
  if obj
    req.showMsg = true
    req.msgMsg =  'Book has been created'
    res.redirect '/books'
    # res.render 'books',
    # title: 'books',
    # message:
    #   show: true
    #   msg: 'Book has been created'
  else
    res.render 'booksCreate',
    title: 'Create a book',
    message:
      show:true,
      msg:'An error on create book has ocurred'
    data:
      book_id:''
      book_name: req.body.book_name
  return

module.exports = router
