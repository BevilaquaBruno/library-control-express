myutils = exports ? this
myutils.sendPost = (url, form) ->
  object = {}
  formData = new FormData form
  formData.forEach (value, key) ->
    object[key] = value
  jsonData = JSON.stringify(object)

  fetch(url,
    method: 'post'
    headers: new Headers(
      'content-type': 'application/json')
    body: jsonData).then((response) ->
      response.json().then (data) ->
        console.log data
        if data.show is true
          alert data.msg
        if data.redirect isnt false
          window.location.href = data.redirect
    ).catch (err) ->
      console.error 'Failed retrieving information', err
    return
