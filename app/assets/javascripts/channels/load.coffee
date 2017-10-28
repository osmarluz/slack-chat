$(document).on 'turbolinks:load', ->
  if $('ul.channels li:first div a span').attr('id') != undefined
    window.open($('ul.channels li:first div a span').attr('id'), 'channels')

  $('body').on 'click', 'a.open_channel', (e) ->
    window.open(e.target.id, 'channels')
