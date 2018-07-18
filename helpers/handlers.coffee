exports.fieldExists = (field) ->
  field = null;
  switch field
    when '', null, undefined
      return false
  true
