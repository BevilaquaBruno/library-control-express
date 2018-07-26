document.getElementById('submitBookUpdate').addEventListener 'click', (e) ->
  e.preventDefault();
  sendPut 'http://localhost:3000/books/update', document.getElementById('formUpdateBook')
  return
