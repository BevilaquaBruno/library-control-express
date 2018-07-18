myutils = exports ? this
myutils.sendPost = (url, form) ->
  form = document.getElementById form
  fetch(url,
    method: 'post'
    headers: new Headers
      'Content-Type': 'application/json'
    body: new FormData(form)).then((response) ->
    console.log response
  ).catch (err) ->
    console.error err
    return
