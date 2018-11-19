# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('.write-icon img.write-icon').click ->
        if $('.message-wrap .textbox').css('visibility') == 'hidden'
            $('.message-wrap .textbox, input#send').css('visibility', 'visible')
        else
            $('.message-wrap .textbox, input#send').css('visibility', 'hidden')
        return
    $('.unread-icon img.unread-icon').click ->
        update()
        return
    update = ->
      if window.location.href.match(/\/home\/main/)
        $.ajax(url: location.href + '.json').done((json) ->
          id = 0
          if json.id > id
            window.location.href = '/home/message/' + json.id
          else
            alert "未読はないみたい"
          return
          $('.post_all').append insertHTML
          return
        ).fail (json) ->
          return
      return
    return


# メッセージを送った時に成功 or 失敗
$(document).on 'ajax:success', '#message_form', (e) ->
  console.log e.detail[0]
  $('textarea#message').val ''
  alert 'めっせーじをおくりました...'
  return
$(document).on 'ajax:error', '#message_form', (e) ->
  console.log e.detail[2]
  $('textarea#message').val ''
  alert 'めっせーじをおくれなかったみたい...'
  return

# ボタン・ボトルをクリックした時、投稿一覧外の領域をクリックした時の処理
$(document).on 'click touchend', (e) ->
    $('.button-wrap .button').click ->
        if $(this).find('a').attr('target') == '_blank'
            window.open $(this).find('a').attr('href'), '_blank'
        else
            window.location = $(this).find('a').attr('href')
        false

    ###
    if !$(e.target).closest('.post_all').length and !$(e.target).closest('.unread-icon img.unread-icon').length
        $('.post_all').fadeOut()
    else if $(e.target).closest('.unread-icon img.unread-icon').length
        if $('.post_all').is(':hidden')
            $('.post_all').fadeIn()
            $('#overlay').fadeIn()
        else
            $('.post_all').fadeOut()
    $('#overlay, .post_all a').unbind().click ->
        $('#overlay').fadeOut()
        $('.post_all').fadeOut()
    return
    ###

return
