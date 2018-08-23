document.getElementById('submitPublisherUpdate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPut 'http://localhost:3000/publishers/update', document.getElementById('formUpdatePublisher')
  return
