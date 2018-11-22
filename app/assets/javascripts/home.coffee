# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# ローディングアニメーション
stopload = ->
    $('.loading').delay(1000).fadeOut 700
    return

$(window).on 'load', ->
    # ロードし終わったらローディング画面をフェードアウト
    $('.loading').delay(1000).fadeOut 400
    return

$ ->
    messageid = ''  # 返信できたメッセージID格納用

    # 書き込みボタンをクリックした時、表示・非表示切り替え
    $('.write-icon img.write-icon').click ->
        if $('.message-wrap .textbox').css('visibility') == 'hidden'
            $('.message-wrap .textbox, input#send').css('visibility', 'visible')
        else
            $('.message-wrap .textbox, input#send').css('visibility', 'hidden')
            $("#message").css("box-shadow","");
            $(".error").fadeOut();
        return

    # 未読アイコン(赤)をクリックした時
    $('.unread-icon img.unread-icon').click ->
        unread_receive()    # 未読のメッセージを探しに行く
        return

    # 返信未読アイコン(緑)をクリックした時
    $('.unread-receive-icon img.unread-receive-icon').click ->
        window.location.href = '/home/message/' + messageid # 該当メッセージへ遷移
        return

    # 返信メッセージを探しに行く
    reply_receive = ->
        if window.location.href.match(/\/home\/main/)   # メインページに居る時のみ
            $.ajax(url: location.href + '.json').done((json) ->
                if json.dst_id == json.user_id  # 自身のユーザIDと宛先ユーザIDが同じとき
                    messageid = json.id # そのメッセージのIDを取得
                    $('.unread-receive-icon').fadeIn(); # 返信未読アイコンを表示
                return
            ).fail (json) ->
                return
        return

    # 未読のメッセージを探しに行く
    # 既読フラグがfalse かつ 自分が送っていない かつ 宛先が存在しないもの で最古のもの
    unread_receive = ->
        $.ajax(url: location.href + '.json').done((json) ->
            if json.id > 0  # メッセージが見つかった時
                window.location.href = '/home/message/' + json.id   # 見つかったメッセージに遷移
            else    # メッセージが見つからない時
                alert "みつからなかったみたい…"
            return
        ).fail (json) ->
            return
        return

    $ ->
        # 定期的に返信が来ていないか確認
        reply_receive()
        setInterval reply_receive, 5000
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
    alert 'めっせーじをおくれなかったみたい...'
    return

# ボタン全体にリンクを効かせる
$(document).on 'click touchend', (e) ->
    $('.button-wrap .button').click ->
        if $(this).find('a').attr('target') == '_blank'
            window.open $(this).find('a').attr('href'), '_blank'
        else
            window.location = $(this).find('a').attr('href')
        false
return
