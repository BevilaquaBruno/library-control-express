express = require 'express'
router = express.Router()
hash = require 'object-hash'
publishersModel = require '../models/publishersModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

router.get '/', (req, res) ->
  publishersList = publishersModel.getAll true, (err, body) ->
    if body.rows <= 0 or err
      show = true
      msg = 'Error on get publishers'
    else
      show = false
      msg = 'page open'

    res.render 'publishers/publishers',
      title: 'Publishers'
      data:body.rows
      show:show
      msg:msg
    return

router.get '/create', (req, res) ->
  res.render 'publishers/publishersCreate',
    title: 'Create a Publisher'
    show: false
    msg: 'page open'

router.post '/create', (req, res) ->
  req.body.publisher_timestamp = timestamp 'YYYYMMDDmmss'
  msg_error = null
  if !field_validator.fieldExists req.body.publisher_name
    msg_error = 'Name is invalid !'
  else if !field_validator.dateExistsBefore req.body.publisher_foundationdate
    msg_error = 'Foundation date must be before today'

  if msg_error isnt null
    res.status(422).json(
      msg: msg_error
      show:true
      redirect:false
      success:false
    )
  else
    myHash = hash req.body
    publishersModel.create req.body, myHash, (err, body) ->
      if !err
        res.status(200).json(
          msg: 'Publisher has been created'
          show: true
          success:true
          redirect: '/publishers'
        )
      else
        res.status(409).json(
          msg: 'Error on create publisher'
          show: true
          success: false
          redirect: false
        )

router.delete '/delete/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg:'Error on identfying publisher'
      success: false
      show: true
      redirect: '/publishers'
    )

  publishersModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg: 'Genre deleted !'
        success: true
        show: true
        redirect: '/publishers'
      )
    else
      res.status(200).json(
        msg: 'Error on delete publisher'
        success: false
        show: true
        redirect: false
      )

router.get '/update/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error on identifying publisher'
      success: true
      show: true
      redirect: '/publishers'
    )
  publishersModel.getPublisherById req.params.id, (err, thispublisher) ->
    if err
      res.status(422).json(
        msg: 'Error on get publisher'
        show: true
        redirect: '/publishers'
        success:false
      )
    res.render 'publishers/publisherUpdate',
      title: 'Update a publisher'
      msg: 'page open'
      show: false
      data: thispublisher

router.put '/update', (req, res) ->
  if !field_validator.fieldExists req.body.publisher_name or !field_validator.dateExistsBefore req.body.publisher_foundationdate  
    res.status(422).json(
      msg: 'Publisher description is undefined'
      show: true
      success:false
      redirect:false
    )
  else
    publishersModel.update req.body, (err, body) ->
      if err
        res.status(422).json(
          msg: 'Error on update publisher'
          show:true
          success:false
          redirect:false
        )
      else
        res.status(200).json(
          msg: 'Publisher has been updated'
          show: true
          success: true
          redirect: '/publishers'
        )

module.exports = router