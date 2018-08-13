genres = require('../couchdb').use('genres')

exports.getAll = (doc, callback) ->
  genres.list { include_docs: doc }, (err, body)->
    callback err, body

exports.create = (genre, myHash, callback) ->
  return genres.insert {_id: myHash, timestamp: genre.genre_timestamp, description: genre.genre_description }, (err, body) ->
    callback err, body

exports.delete = (genre_id, callback) ->
  return genres.get genre_id, (err, body) ->
    genres.destroy body._id, body._rev, (err, body) ->
      callback err, body

exports.getGenreById = (id, callback) ->
  genres.list { include_docs: true }, (err, body) ->
    if err
      callback err, body
    else
      for item in body.rows
        if item.doc._id is id
          callback err, item.doc

exports.update = (genre, callback) ->
  genres.insert { _id: genre.genre_id, _rev: genre.genre_rev, description: genre.genre_description }, (err, body) ->
    callback err, body
  return