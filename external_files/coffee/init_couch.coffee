async = require 'async'
couch = require './couchdb'

databases = [
  'books'
]

initCouch = (cb)->
  createDatabases cb

createDatabases = (cb) ->
  async.each databases, createDatabase, cb

createDatabase = (db, cb) ->
  couch.db.create db, (err) ->
    if err and err.statusCode is 412
      err = null
    cb err;

module.exports = initCouch;
