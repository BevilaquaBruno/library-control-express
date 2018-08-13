express = require 'express'
router = express.Router()
hash = require 'object-hash'
authorsModel = require '../models/authorsModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

router.get '/', (req, res) ->
  authorsModel.getAll(true, (err, body) ->
    if body.rows > 0 or err
      show = true
      msg = 'Error on get authors'
    else
      show = false
      msg = 'page open'

    res.render 'authors/authors',
      title: 'Authors',
      data: body.rows
      show: show
      msg:  msg
    return
  )

router.get '/create', (req, res) ->

  res.render 'authors/authorsCreate',
      title: 'Create a author'
      show: false,
      msg: 'page open'
      success: true
      data: null

router.post '/create', (req, res) ->
  error_msg = null
  if !field_validator.fieldExists req.body.author_name
    error_msg = 'Author name is undefined'
  if !field_validator.fieldExists req.body.author_fullname
    error_msg = 'Author full name is undefined'
  if !field_validator.dateExistsBefore req.body.author_birthdate
    error_msg = 'The birth date have to be before today'

  if error_msg isnt null
    return res.status(422).json(
      msg: error_msg
      show: true
      success: false
      redirect: false
    )
  req.body.author_timestamp = timestamp 'YYYYMMDDmmss'
  myHash = hash req.body
  authorsModel.create req.body, myHash, (err, body) ->
    if !err
      res.status(200).json(
        msg: 'Author has been create'
        show: true
        success: true
        redirect: '/authors'
      )
    else
      res.status(409).json(
        msg: 'Error on create author'
        show: true
        success: obj
        redirect: false
      )

router.delete '/delete/:id', (req, res) ->

  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying author'
      success: false
      show: true
      redirect: '/authors'
    )
  obj = authorsModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg:'Author deleted !'
        success: true
        show: true
        redirect: '/authors'
      )
    else
      res.status(422).json(
        msg:'Error on delete author'
        success: false
        show: true
        redirect: false
      )

router.get '/update/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error identifying book'
      success: false
      show: true
      redirect: '/authors'
    )
  authorsModel.getAuthorById req.params.id, (err, thisauthor) ->
    if err
      res.status(422).json(
        msg: 'Error on get author'
        show: true,
        redirect: '/books'
        success: false
      )
    res.render 'authors/authorsUpdate',
      title: 'Update a author'
      msg: 'page open'
      show: false
      data: thisauthor

router.put '/update', (req, res) ->
  error_msg = null
  redirect = false
  if !field_validator.fieldExists req.body.author_name
    error_msg = 'Author name is undefined'
  if !field_validator.fieldExists req.body.author_fullname
    error_msg = 'Author full name is undefined'
  if !field_validator.dateExistsBefore req.body.author_birthdate
    error_msg = 'The birth date have to be before today'
  if !field_validator.fieldExists req.body.author_id or !field_validator.fieldExists req.body.author_rev
    error_msg = 'Some error has ocurred with the data'
    redirect = true
  if error_msg isnt null
    return res.status(422).json(
      msg: error_msg
      show: true
      success: false
      redirect: redirect
    )
  authorsModel.update req.body, (err, body) ->
    if err
      res.status(422).json(
        msg: 'Error on update author'
        show: true
        sucess: false
        redirect: false
      )
    else
      res.status(200).json(
        msg: 'Author has been updated'
        show: true
        success: true
        redirect: '/authors'
      )
module.exports = router
