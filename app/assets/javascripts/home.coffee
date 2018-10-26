# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# メッセージを送った時に成功 or 失敗
$(document).on 'ajax:success', '#message_form', (e) ->
  console.log e.detail[0]
  $('textarea#message').val ''
  alert 'メッセージを海に流しました...'
  return
$(document).on 'ajax:error', '#message_form', (e) ->
  console.log e.detail[2]
  $('textarea#message').val ''
  alert 'メッセージが届かなかったみたい...'
  return
