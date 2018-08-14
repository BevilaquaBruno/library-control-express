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

module.exports = router