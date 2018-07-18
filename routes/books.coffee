express = require 'express'
router = express.Router()
hash = require 'object-hash'
booksModel = require '../models/booksModel'
timestamp = require 'time-stamp'
utils = require '../public/javascripts/utils'

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

router.delete '/delete/:id', (req, res)->
  if !isNaN req.params.id
    {msg: 'Error identifying book', success: false, show: true, redirect: '/books'}
  obj = booksModel.delete req.params.id
  if obj
    {msg:'Book deleted !', success: obj, show: true, redirect: '/books'}
  else
    {msg:'Error on delete book', success: obj, show: true, redirect: false}

router.get '/create', (req, res) ->
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
    {msg: 'books has been create', show: true, success: obj, redirect: '/books'}
  else
    {msg: 'Error on create book', show: true, success: obj, redirect: false}

module.exports = router
