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
          showModalAlert data.msg, data.success, data.redirect
        else if data.redirect isnt false
          window.location.href = data.redirect
    ).catch (err) ->
      console.error 'Failed retrieving information', err
    return

myutils.sendPut = (url, form) ->
  object = {}
  formData = new FormData form
  formData.forEach (value, key) ->
    object[key] = value
  jsonData = JSON.stringify(object)

  fetch(url,
    method: 'put'
    headers: new Headers(
      'content-type': 'application/json')
    body: jsonData).then((response) ->
      response.json().then (data) ->
        console.log data
        if data.show is true
          showModalAlert data.msg, data.success, data.redirect
        else if data.redirect isnt false
          window.location.href = data.redirect
    ).catch (err) ->
      console.error 'Failed retrieving information', err
    return


myutils.sendDelete = (url) ->
  fetch(url,
    method: 'delete'
    headers: new Headers(
      'content-type': 'application/json')
  ).then((response) ->
    response.json().then (data) ->
      console.log data
      if data.show is true
        showModalAlert data.msg, data.success, data.redirect
    ).catch (err) ->
      console.error 'Failed retrieving information', err
    return

myutils.showModalAlert = (msg, success, redirect) ->
  modal = document.getElementById 'modalAlert'
  btnCloseModal = document.getElementById 'btnCloseModal'
  modalBody = document.getElementById 'modalBody'
  xCloseModal = document.getElementById 'xCloseModal'

  modalBody.innerHTML = msg
  modal.className = 'modal modal-sm active'
  if redirect isnt false
    btnCloseModal.innerHTML = 'Allright'
    btnCloseModal.href = redirect || '#myMenu'
    xCloseModal.href = redirect || '#myMenu'
  else
    btnCloseModal.addEventListener 'click', (e) ->
      e.preventDefault()
      modal.className = 'modal modal-sm'
    xCloseModal.addEventListener 'click', (e) ->
      e.preventDefault()
      modal.className = 'modal modal-sm'
