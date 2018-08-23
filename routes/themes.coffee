express = require 'express'
router = express.Router()
hash = require 'object-hash'
themesModel = require '../models/themesModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

router.get '/', (req, res) ->
  themesList = themesModel.getAll true, (err, body) ->
    if body.rows <= 0 or err
      show = true
      msg = 'Error on get themes'
    else
      show = false
      msg = 'page open'

    res.render 'themes/themes',
      title: 'Themes'
      data: body.rows
      show: show
      msg: msg
    return

router.get '/create', (req, res) ->
  res.render 'themes/themesCreate',
    title: 'Create a Theme'
    show: false
    msg: 'page open'

router.post '/create', (req, res) ->
  req.body.theme_timestamp = timestamp 'YYYYMMDDmmss'
  if !field_validator.fieldExists req.body.theme_description
    res.status(422).json(
      msg: 'Theme description is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    myHash = hash req.body
    themesModel.create req.body, myHash, (err, body) ->
      if !err
        res.status(200).json(
          msg: 'Themes has been create'
          show: true
          success: true
          redirect: '/themes'
        )
      else
        res.status(409).json(
          msg: 'Error on create theme'
          show: true
          success: false
          redirect: false
        )

router.delete '/delete/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg:'Error on idenfying theme'
      success: false
      show: true
      redirect: '/themes'
    )
  themesModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg:'Theme deleted !'
        success: true
        show: true
        redirect: '/themes'
      )
    else
      res.status(422).json(
        msg:'Error on delete theme'
        success: false
        show: true
        redirect: false
      )

router.get '/update/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error on identifying theme'
      success: true
      show: true
      redirect: '/themes'
    )
  themesModel.getThemeById req.params.id, (err, thistheme) ->
    if err
      res.status(422).json(
        msg: 'Error on get theme'
        show: true,
        redirect: '/themes'
        success: false
      )
    res.render 'themes/themesUpdate',
      title: 'Update a Theme'
      msg: 'page open'
      show: false
      data: thistheme

router.put '/update', (req, res) ->
  if !field_validator.fieldExists req.body.theme_description
    res.status(422).json(
      msg: 'Theme description is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    themesModel.update req.body, (err, body) ->
      if err
        res.status(422).json(
          msg: 'Error on update theme'
          show: true
          success: false
          redirect: false
        )
      else
        res.status(200).json(
          msg: 'Themes has been updated'
          show: true
          success: true
          redirect: '/themes'
        )

module.exports = router
