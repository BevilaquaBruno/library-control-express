document.getElementById('submitAuthorCreate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPost 'http://localhost:3000/authors/create', document.getElementById('formCreateAuthor')
  return
