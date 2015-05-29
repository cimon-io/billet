#= require jquery
#= require moment
#= require moment-timezone

updateDate = (el)->
  $e = $(el)
  m = moment($e.attr('data-timestamp'))
  return unless m.isValid()
  if $e.data('timestamp-format') is 'fromNow'
    $e.html m.fromNow()
  else
    $e.html m.tz($('meta[name=timezone-format]').attr('content')).format($('meta[name=date-time-format]').attr('content'))

  $(document).find(el).each ->
    diff = moment().diff(m, 'minute', true)
    setTimeout (=> updateDate(@)), switch
      when diff < 1 then 1000
      when diff < 60 then 1000*60
      else 1000*60*60

$(document).on 'ready page:load ajaxComplete nested:fieldAdded', (e)->
  $(e.field or e.target).find('[data-timestamp]').each ->
    return if $(@).data('timestamp-activated')
    $(@).on 'changed', (e, date)->
      $(@).attr('data-timestamp', moment(date).tz('UTC').format(moment.ISO_8601()))
      updateDate(@)
    updateDate(@)
    $(@).data('timestamp-activated', true)
