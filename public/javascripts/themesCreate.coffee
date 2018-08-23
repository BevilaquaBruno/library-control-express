document.getElementById('submitThemeCreate').addEventListener 'click', (e) ->
  e.preventDefault()
  sendPost 'http://localhost:3000/themes/create', document.getElementById('formCreateTheme')
  return
