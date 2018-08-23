themes = require('../couchdb').use('themes')

exports.getAll = (doc, callback) ->
  themes.list { include_docs: doc }, (err, body)->
    callback err, body

exports.create = (theme, myHash, callback) ->
  return themes.insert {_id: myHash, timestamp: theme.theme_timestamp, description: theme.theme_description }, (err, body) ->
    callback err, body

exports.delete = (theme_id, callback) ->
  return themes.get theme_id, (err, body) ->
    themes.destroy body._id, body._rev, (err, body) ->
      callback err, body

exports.getThemeById = (id, callback) ->
  themes.list { include_docs: true }, (err, body) ->
    if err
      callback err, body
    else
      for item in body.rows
        if item.doc._id is id
          callback err, item.doc

exports.update = (theme, callback) ->
  themes.insert { _id: theme.theme_id, _rev: theme.theme_rev, description: theme.theme_description }, (err, body) ->
    callback err, body
  return