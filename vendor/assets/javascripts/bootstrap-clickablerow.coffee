do ($=jQuery)->
  $(document).on 'click', '[data-link]', (e)->
    return if $(e.target).is(':link')  or $(e.target).is(':input')
    if window['Turbolinks']
      Turbolinks.visit $(@).data('link')
    else
      window.location = $(@).data('link')
