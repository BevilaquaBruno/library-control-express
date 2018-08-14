publishers = require('../couchdb').use('publishers')

exports.getAll = (doc, callback) ->
  publishers.list { include_docs: doc }, (err, body) ->
    callback err, body

exports.create = (publisher, myHash, callback) ->
  return publishers.insert {id: myHash, timestamp: publisher.publisher_timestamp, name: publisher.publisher_name, foundationdate: publisher.publisher_foundationdate, founders: publisher.publisher_founders, headquarters: publisher.publisher_headquarters, website:publisher.publisher_website }, (err, body) ->
    callback err, body