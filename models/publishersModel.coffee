publishers = require('../couchdb').use('publishers')

exports.getAll = (doc, callback) ->
  publishers.list { include_docs: doc }, (err, body) ->
    callback err, body

exports.create = (publisher, myHash, callback) ->
  return publishers.insert {id: myHash, timestamp: publisher.publisher_timestamp, name: publisher.publisher_name, foundationdate: publisher.publisher_foundationdate, founders: publisher.publisher_founders, headquarters: publisher.publisher_headquarters, website:publisher.publisher_website }, (err, body) ->
    callback err, body

exports.delete = (publisher_id, callback) ->
  return publishers.get publisher_id, (err, body) ->
    publishers.destroy body._id, body._rev, (err, body) ->
      callback err, body

exports.getPublisherById = (id, callback) ->
  publishers.list { include_docs: true }, (err, body) ->
    if err
      callback err,body
    else
      for item in body.rows
        if item.doc._id is id
          callback err, item.doc

exports.update = (publisher, callback) ->
  publishers.insert { _id: publisher.publisher_id, _rev: publisher.publisher_rev, name: publisher.publisher_name, foundationdate: publisher.publisher_foundationdate, founders: publisher.publisher_founders, headquarters: publisher.publisher_headquarters, website:publisher.publisher_website }, (err, body) ->
    callback err, body
  return