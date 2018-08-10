document.getElementById('submitGenreCreate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPost 'http://localhost:3000/genres/create', document.getElementById('formCreateGenre')
  return
