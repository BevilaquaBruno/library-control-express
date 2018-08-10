genres = require('../couchdb').use('genres')

exports.getAll = (doc, callback) ->
  genres.list { include_docs: doc }, (err, body)->
    callback err, body

exports.create = (genre, myHash, callback) ->
  return genres.insert {_id: myHash, timestamp: genre.genre_timestamp, description: genre.genre_description }, (err, body) ->
    callback err, body