# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    update = ->
      if window.location.href.match(/\/home\/main/)
        $.ajax(url: location.href + '.json').done((json) ->
          if $('.message_item').length
            id = $('.message_item:last').data('message-id')
            $('.bottle').fadeIn()
          else
            id = 0
          insertHTML = ''
          if json.id > id
            insertHTML = $('.post_all').append('
                <div class="message_item" data-message-id=' + json.id + '>
                    <p>' + json.id + 'ばん ' + json.date + '</p>
                    <a href="/home/message/' + json.id + '">めっせーじをみる</a>
                </div>
            ')
          return
          $('.post_all').append insertHTML
          return
        ).fail (json) ->
          return
      else
        clearInterval update
      return
    $ ->
        update()
        setInterval update, 10000
        return
    return


# メッセージを送った時に成功 or 失敗
$(document).on 'ajax:success', '#message_form', (e) ->
  console.log e.detail[0]
  $('textarea#message').val ''
  alert 'めっせーじをうみにながしました...'
  return
$(document).on 'ajax:error', '#message_form', (e) ->
  console.log e.detail[2]
  $('textarea#message').val ''
  alert 'めっせーじはとどかなかったみたい...'
  return

# ボトルをクリックした時、投稿一覧外の領域をクリックした時の処理
$(document).on 'click touchend', (e) ->
    if !$(e.target).closest('.post_all').length and !$(e.target).closest('.bottle img.bottle-icon').length
        $('.post_all').fadeOut()
    else if $(e.target).closest('.bottle img.bottle-icon').length
        if $('.post_all').is(':hidden')
            $('.post_all').fadeIn()
            $('#overlay').fadeIn()
        else
            $('.post_all').fadeOut()
    $('#overlay, .post_all a').unbind().click ->
        $('#overlay').fadeOut()
        $('.post_all').fadeOut()
    return
return

$ ->
    $('.bottle img.bottle-icon').on 'click', ->
        $('.post_all').css('display', 'flex').hide().fadeIn()
        return
