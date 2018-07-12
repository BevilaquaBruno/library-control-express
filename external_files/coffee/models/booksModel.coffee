books = require('../couchdb').use('books')

exports.create = (book, myHash) ->
  return books.insert {_id: myHash, timestamp: book.book_timestamp, name: book.book_name}, (err, body) ->
    if err
      return false
    else
      return true
    return
  return

exports.delete = (book) ->
  return books.get book.book_id, (err, body) ->
    books.destroy body._id,  body._rev, (err, body) ->
      if err
        return false
      else
        return true
    return
  return

exports.getAll = (docs) ->
  books.list { include_docs: docs }, (err, body) ->
    if err
      return false
    else
      content = []
      body.rows.forEach (doc) ->
        content.push doc.doc
      return content
