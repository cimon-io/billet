#=require jquery

$(document).on 'change blur', "form[data-autosubmit] :input, .autosubmit:input, form[data-autosubmit] textarea", ()->
  if $(@).parents('form [type=submit]').count > 0
    $(@).parents('form [type=submit]').click()
  else
    $(@).parents('form').trigger('submit')
