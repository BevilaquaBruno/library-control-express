document.getElementById('submitBook').addEventListener 'click', (e) ->
  e.preventDefault();
  sendPost 'http://localhost:3000/books/create', document.getElementById('formCreateBook')
  return
