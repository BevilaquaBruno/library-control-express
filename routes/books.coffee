express = require 'express'
router = express.Router()
hash = require 'object-hash'
booksModel = require '../models/booksModel'
timestamp = require 'time-stamp'
handlers = require '../helpers/handlers'

# GET home page.asdasd
router.get '/', (req, res) ->
  booksList = booksModel.getAll(true, (err, body) ->
    if body.rows > 0 or err
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
<<<<<<< HEAD
    res.status(200).json(
=======
    res.status(422).json(
>>>>>>> a3e29bba8daf5e36ce6d6cf18b2f038c7072fa8b
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/books'
    )
  obj = booksModel.delete req.params.id
  if obj
    res.status(200).json(
      msg:'Book deleted !'
      success: obj
      show: true
      redirect: '/books'
    )
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
  if !handlers.fieldExists req.body.book_name
<<<<<<< HEAD
    res.status(422).send(
=======
    res.status(422).json(
>>>>>>> a3e29bba8daf5e36ce6d6cf18b2f038c7072fa8b
      msg: 'Book name is undefined'
      show: true
      success: false
      redirect: false
      )
<<<<<<< HEAD
  else
    myHash = hash req.body
    obj = booksModel.create req.body, myHash
    if obj
      res.status(200).json(
        msg: 'books has been create'
        show: true
        success: obj
        redirect: '/books'
      )
    else
      res.status(200).json(
        msg: 'Error on create book'
        show: true
        success: obj
        redirect: false
      )
=======
  myHash = hash req.body
  obj = booksModel.create req.body, myHash
  if obj
    res.status(200).json(
      msg: 'books has been create'
      show: true
      success: obj
      redirect: '/books'
    )
  else
    res.status(409).json(
      msg: 'Error on create book'
      show: true
      success: obj
      redirect: false
    )
>>>>>>> a3e29bba8daf5e36ce6d6cf18b2f038c7072fa8b

module.exports = router
