document.getElementById('submitThemeUpdate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPut 'http://localhost:3000/themes/update', document.getElementById('formUpdateTheme')
  return
