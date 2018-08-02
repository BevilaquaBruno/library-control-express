validator = require 'validator'
timestamp = require 'time-stamp'

exports.fieldExists = (field) ->
  switch field
    when '', null, undefined
      return false
  true

exports.dateExistsBefore = (field) ->
  validator.isBefore field, timestamp('YYYY-MM-DD')
