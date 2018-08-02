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

module.exports = router
