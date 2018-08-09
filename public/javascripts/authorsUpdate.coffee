document.getElementById('submitAuthorUpdate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPut 'http://localhost:3000/authors/update', document.getElementById('formUpdateAuthor')
  return
