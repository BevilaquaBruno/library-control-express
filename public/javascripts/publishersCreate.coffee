document.getElementById('submitPublisherCreate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPost 'http://localhost:3000/publishers/create', document.getElementById('formCreatePublisher')
  return