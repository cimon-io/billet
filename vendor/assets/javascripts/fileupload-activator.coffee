#= require jquery-fileupload/basic

$(document).on 'ready page:load', ->
  $('form[data-attachment=form]').each ->
    $(@).find('input[type=file]').fileupload
      dataType: 'script'
      dropZone: $($(@).data('attachment-dropzone'))

  $('[data-attachment=link]').on 'click', (event)->
    event.preventDefault()
    $($(@).data('attachment-form')).find('input[type=file]').click()

$(document).on 'drop dragover', (e)-> e.preventDefault()
