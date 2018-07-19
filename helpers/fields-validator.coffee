exports.fieldExists = (field) ->  
  switch field
    when '', null, undefined
      return false
  true
