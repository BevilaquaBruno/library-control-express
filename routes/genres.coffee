express = require 'express'
router = express.Router()
hash = require 'object-hash'
genresModel = require '../models/genresModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

router.get '/', (req, res) ->
  genresList = genresModel.getAll true, (err, body) ->
    if body.rows <= 0 or err
      show = true
      msg = 'Error on get genres'
    else
      show = false
      msg = 'page open'

    res.render 'genres/genres',
      title: 'Genres'
      data: body.rows
      show: show
      msg: msg
    return

router.get '/create', (req, res) ->
  res.render 'genres/genresCreate',
    title: 'Create a Genre'
    show: false
    msg: 'page open'

router.post '/create', (req, res) ->
  req.body.genre_timestamp = timestamp 'YYYYMMDDmmss'
  if !field_validator.fieldExists req.body.genre_description
    res.status(422).json(
      msg: 'Genre description is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    myHash = hash req.body
    genresModel.create req.body, myHash, (err, body) ->
      if !err
        res.status(200).json(
          msg: 'Genres has been create'
          show: true
          success: true
          redirect: '/genres'
        )
      else
        res.status(409).json(
          msg: 'Error on create genre'
          show: true
          success: false
          redirect: false
        )

router.delete '/delete/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg:'Error on idenfying genre'
      success: false
      show: true
      redirect: '/genres'
    )
  genresModel.delete req.params.id, (err, body) ->
    if !err
      res.status(200).json(
        msg:'Genre deleted !'
        success: true
        show: true
        redirect: '/genres'
      )
    else
      res.status(422).json(
        msg:'Error on delete genre'
        success: false
        show: true
        redirect: false
      )

router.get '/update/:id', (req, res) ->
  if !field_validator.fieldExists req.params.id
    res.status(422).json(
      msg: 'Error on identifying genre'
      success: true
      show: true
      redirect: '/genres'
    )
  genresModel.getGenreById req.params.id, (err, thisgenre) ->
    if err
      res.status(422).json(
        msg: 'Error on get genre'
        show: true,
        redirect: '/genres'
        success: false
      )
    res.render 'genres/genresUpdate',
      title: 'Update a Genre'
      msg: 'page open'
      show: false
      data: thisgenre

router.put '/update', (req, res) ->
  if !field_validator.fieldExists req.body.genre_description
    res.status(422).json(
      msg: 'Genre description is undefined'
      show: true
      success: false
      redirect: false
    )
  else
    genresModel.update req.body, (err, body) ->
      if err
        res.status(422).json(
          msg: 'Error on update genre'
          show: true
          success: false
          redirect: false
        )
      else
        res.status(200).json(
          msg: 'Genres has been updated'
          show: true
          success: true
          redirect: '/genres'
        )

module.exports = router
