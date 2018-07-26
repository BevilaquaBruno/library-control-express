books = require('../couchdb').use('books')

exports.create = (book, myHash, callback) ->
  return books.insert {_id: myHash, timestamp: book.book_timestamp, name: book.book_name}, (err, body) ->
    callback(err, body)

exports.delete = (book_id, callback) ->
  return books.get book_id, (err, body) ->
    books.destroy body._id,  body._rev, (err, body) ->
      callback(err, body)

exports.getAll = (docs, callback) ->
  books.list { include_docs: docs }, (err, body) ->
    callback(err,body)

exports.getBookById = (id, callback) ->
  # books.get id, {revs_info: true}, callback
  # do this
