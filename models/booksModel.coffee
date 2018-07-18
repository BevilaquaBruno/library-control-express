books = require('../couchdb').use('books')

exports.create = (book, myHash) ->
  return books.insert {_id: myHash, timestamp: book.book_timestamp, name: book.book_name}, (err, body) ->
    if err
      return false
    else
      return true
    return
  return

exports.delete = (book_id) ->
  return books.get book_id, (err, body) ->
    books.destroy body._id,  body._rev, (err, body) ->
      if err
        return false
      else
        return true
    return
  return

exports.getAll = (docs, callback) ->
  books.list { include_docs: docs }, (err, body) ->
    callback(err,body)
