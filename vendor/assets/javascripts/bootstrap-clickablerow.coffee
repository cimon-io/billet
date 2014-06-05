do ($=jQuery)->
  $(document).on 'click', '[data-link]', ()->
    if window['Turbolinks']
      Turbolinks.visit $(@).data('link')
    else
      window.location = $(@).data('link')
