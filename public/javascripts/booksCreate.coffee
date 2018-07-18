utils = new utils()

document.getElementById('submitBook').addEventListener 'click', (e) ->
  e.preventDefault();
  utils.sendPost '/books/create', 'formCreateBook'
  return
