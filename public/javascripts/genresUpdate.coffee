document.getElementById('submitGenreUpdate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPut 'http://localhost:3000/genres/update', document.getElementById('formUpdateGenre')
  return
