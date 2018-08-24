express = require 'express'
router = express.Router()
hash = require 'object-hash'
booksModel = require '../models/booksModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

# GET home page.asdasd
router.get '/', (req, res) ->
  authorsModel = require '../models/authorsModel'
  booksList = booksModel.getAll(true, (err, body) ->
    if body.rows > 0 or err
      show = true
      msg = 'Error on get books'
    else
      show = false
      msg = 'page open'
    arrBooks = body.rows

    authorsModel.getAll true, (err, authors) ->    
      add = (i, author) ->        
        if arrBooks[i].doc.authorid is author.doc._id
          arrBooks[i].doc.author = author                        

      verify = (iBook) ->            
        add iBook, actualAuthor for actualAuthor, i in authors.rows

      verify j for actualBook, j in arrBooks      

      res.render 'books/books',
        title: 'Books',
        data: arrBooks
        show: show
        msg:  msg    
      )    

router.get '/create', (req, res) ->
  authorsModel = require '../models/authorsModel'
  genresModel = require '../models/genresModel'
  publishersModel = require '../models/publishersModel'
  themesModel = require '../models/themesModel'

  authorsModel.getAll true, (err, body) ->
    authors = body.rows
    genresModel.getAll true, (err, body) ->
      genres = body.rows
      publishersModel.getAll true, (err, body) ->
        publishers = body.rows
        themesModel.getAll true, (err, body) ->
          themes = body.rows
          res.render 'books/booksCreate',
            title: 'Create a Book',
            show: false,
            msg:  'page open',
            data: 
              authors: authors,
              genres: genres,
              publishers: publishers,
              themes: themes

router.post '/create', (req, res) ->
  req.body.book_timestamp = timestamp 'YYYYMMDDmmss'
  error_msg = null
  if !field_validator.dateExistsBefore req.body.book_releasedate
    error_msg = 'Book release date must be before today'
  if !field_validator.fieldExists req.body.book_language
    error_msg = 'Book Language is undefined'      
  if !field_validator.fieldExists req.body.book_author
    error_msg = 'Book author is undefined'
  if !field_validator.fieldExists req.body.book_name
    error_msg = 'Book name is undefined'
  if error_msg isnt null    
    res.status(422).json(
      msg: error_msg
      show: true
      success: false
      redirect: false
    )
  else
    myHash = hash req.body
    booksModel.create req.body, myHash, (err, body) ->
      if !err
        res.status(200).json(
          msg: 'Books has been create'
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

router.get '/update/:id', (req, res)->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/books'
    )
  booksModel.getBookById req.params.id, (err, thisbook) ->    
    if err
      res.status(422).json(
        msg: 'Error on get book'
        show: true,
        redirect: '/books'
        success: false
      )
    authorsModel = require '../models/authorsModel'
    genresModel = require '../models/genresModel'
    publishersModel = require '../models/publishersModel'
    themesModel = require '../models/themesModel'
    authorsModel.getAll true, (err, body) ->
      authors = body.rows
      genresModel.getAll true, (err, body) ->
        genres = body.rows
        publishersModel.getAll true, (err, body) ->
          publishers = body.rows
          themesModel.getAll true, (err, body) ->
            themes = body.rows          
            res.render 'books/booksUpdate',
              title: 'Update a book'
              msg: 'page open'
              show: false
              databook: thisbook
              data: 
                authors: authors,
                genres: genres,
                publishers: publishers,
                themes: themes

router.delete '/delete/:id', (req, res)->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/books'
    )
  booksModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg:'Book deleted !'
        success: true
        show: true
        redirect: '/books'
      )
    else
      res.status(422).json(
        msg:'Error on delete book'
        success: false
        show: true
        redirect: false
      )

router.put '/update', (req, res) ->  
  error_msg = null
  if !field_validator.dateExistsBefore req.body.book_releasedate
    error_msg = 'Book release date must be before today'
  if !field_validator.fieldExists req.body.book_language
    error_msg = 'Book Language is undefined'      
  if !field_validator.fieldExists req.body.book_author
    error_msg = 'Book author is undefined'
  if !field_validator.fieldExists req.body.book_name
    error_msg = 'Book name is undefined'
  if error_msg isnt null    
    res.status(422).json(
      msg: error_msg
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
          msg: 'Books has been updated'
          show: true
          success: true
          redirect: '/books'
        )

module.exports = router
