myutils = exports ? this
myutils.sendPost = (url, form) ->
  form = document.getElementById form
  fetch(url,
    method: 'post'
    body: new FormData(form)).then((response) ->
      response.json().then (data) ->

  ).catch (err) ->
    console.error err
    return

myutils.openAlert = (type, msg) ->
  myAlert = document.getElementById 'myAlert'
  type = if type is '' then null else type
  if type is 'error'
    myalert.className = 'errorAlert'
  else if type is 'success'
    myalert.className = 'successAlert'
  else if type is null
    myalert.className = 'infoAlert'
