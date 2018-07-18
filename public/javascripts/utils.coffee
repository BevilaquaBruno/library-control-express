class utils

  sendPost = (url, form) ->
    form = document.getElementById form
    fetch(url,
      method: 'post'
      body: new formData(form)).then((response) ->
      console.log response
    ).catch (err) ->
      console.error err
      return
