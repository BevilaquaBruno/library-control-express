express = require 'express'
router = express.Router()
hash = require 'object-hash'
genresModel = require '../models/genresModel'
timestamp = require 'time-stamp'
field_validator = require '../helpers/fields-validator'

router.get '/', (req, res) ->
  genresList = genresModel.getAll true, (err, body) ->
    if body.rows > 0 or err
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

module.exports = router
