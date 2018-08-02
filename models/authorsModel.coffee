authors = require('../couchdb').use('authors')

exports.getAll = (docs, callback) ->
  authors.list { include_docs: docs }, (err, body) ->
    callback err,body

exports.create = (author, myHash, callback) ->
 return authors.insert {_id: myHash, timestamp: author.author_timestamp, name: author.author_name, fullname: author.author_fullname, deathdate: author.author_deathdate, birthdate: author.author_birthdate,nationality: author.author_nationality, mainlanguage: author.author_mainlanguage, birth_place: author.author_birth_place}, (err, body) ->
   callback err, body

exports.delete = (author_id, callback) ->
  return authors.get author_id, (err, body) ->
    authors.destroy body._id,  body._rev, (err, body) ->
      callback err, body
#
# exports.getBookById = (id, callback) ->
#   authors.list { include_docs: true }, (err, body) ->
#     if err
#       callback err, body
#     else
#       for item in body.rows
#         if item.doc._id is id
#           callback err, item.doc
#
# exports.update = (author, callback) ->
#   authors.insert {_id: author.author_id, _rev: author.author_rev, name: author.author_name},(err, body) ->
#     callback err, body
#   return
