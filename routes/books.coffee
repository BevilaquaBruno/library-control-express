express = require 'express'
router = express.Router()
hash = require 'object-hash'
booksModel = require '../models/booksModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

# GET home page.asdasd
router.get '/', (req, res) ->
  booksList = booksModel.getAll(true, (err, body) ->
    if body.rows > 0 or err
      show = true
      msg = 'Error on get books'
    else
      show = false
      msg = 'page open'

    res.render 'books/books',
    title: 'Books',
    data: body.rows
    show: show
    msg:  msg
    return
    )

router.get '/update/:id', (req, res)->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/books'
    )
  booksModel.getBookById req.params.id, (err, thisbook) ->
    console.log thisbook
    res.render 'books/booksUpdate',
      title: 'Update a book'
      msg: 'page open'
      show: false
      data: thisbook

router.delete '/delete/:id', (req, res)->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/books'
    )
  obj = booksModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg:'Book deleted !'
        success: obj
        show: true
        redirect: '/books'
      )
    else
      res.status(422).json(
        msg:'Error on delete book'
        success: obj
        show: true
        redirect: false
      )

router.get '/create', (req, res) ->
  res.render 'books/booksCreate',
    title: 'Create a Book',
    show: false,
    msg:  'page open'

router.put '/update', (req, res) ->
  if !field_validator.fieldExists req.body.book_name
    res.status(422).json(
      msg: 'Book name is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    booksModel.update req.body, (err, body) ->
      if err
        res.status(422).json(
          msg: 'Error on update book'
          show: true
          sucess: false
          redirect: false
        )
      else
        res.status(200).json(
          msg: 'books has been updated'
          show: true
          success: true
          redirect: '/books'
        )

router.post '/create', (req, res) ->
  req.body.book_timestamp = timestamp 'YYYYMMDDmmss'
  if !field_validator.fieldExists req.body.book_name
    res.status(422).json(
      msg: 'Book name is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    myHash = hash req.body
    obj = booksModel.create req.body, myHash, (err, body) ->
      if !err
        res.status(200).json(
          msg: 'books has been create'
          show: true
          success: true
          redirect: '/books'
        )
      else
        res.status(409).json(
          msg: 'Error on create book'
          show: true
          success: false
          redirect: false
        )

module.exports = router
