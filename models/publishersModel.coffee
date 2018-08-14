publishers = require('../couchdb').use('publishers')

exports.getAll = (doc, callback) ->
  publishers.list { include_docs: doc }, (err, body) ->
    callback err, body