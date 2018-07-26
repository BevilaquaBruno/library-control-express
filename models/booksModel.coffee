books = require('../couchdb').use('books')

exports.create = (book, myHash, callback) ->
  return books.insert {_id: myHash, timestamp: book.book_timestamp, name: book.book_name}, (err, body) ->
    callback err, body

exports.delete = (book_id, callback) ->
  return books.get book_id, (err, body) ->
    books.destroy body._id,  body._rev, (err, body) ->
      callback err, body

exports.getAll = (docs, callback) ->
  books.list { include_docs: docs }, (err, body) ->
    callback err,body

exports.getBookById = (id, callback) ->
  books.list { include_docs: true }, (err, body) ->
    if err
      callback err, body
    else
      for item in body.rows
        if item.doc._id is id
          callback err, item.doc

exports.update = (book, callback) ->
  books.insert {_id: book.book_id, _rev: book.book_rev, name: book.book_name},(err, body) ->
    callback err, body
  return
