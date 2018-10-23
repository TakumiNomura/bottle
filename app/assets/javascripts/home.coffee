# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

input = undefined
input = []
document.addEventListener 'DOMContentLoaded', (->
  document.getElementById('table_name_field_name').addEventListener 'keyup', (e) ->
    tmp = undefined
    tmp = []
    @value.split('').forEach (item, i) ->
      if item.match(/^[\u3040-\u309f]+$/)
        tmp.push item
      return
    if tmp.length > 0
      @value = tmp.join('')
    else
      @value = ''
    return
  return
), false

$(document).on 'click touchend', (e) ->
  $('#send').click ->
    $('input#table_name_field_name').val("")
    alert ("メッセージを放流しました。")
    false
  return