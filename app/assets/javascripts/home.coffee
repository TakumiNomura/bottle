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
            if $('.all-message').css('display') == 'block'
                $('.all-message').fadeOut();
            $('.message-wrap .textbox, input#send').css('visibility', 'visible')
        else
            $('.message-wrap .textbox, input#send').css('visibility', 'hidden')
            $("#message").css("box-shadow","");
            $(".error").css('visibility', 'hidden');
        return

    # かばんボタンをクリックした時、表示・非表示切り替え
    $('.bag-icon img.bag-icon').click ->
        if $('.all-message').css('display') == 'none'
            if $('.message-wrap .textbox').css('visibility') == 'visible'
                $('.message-wrap .textbox, input#send').css('visibility', 'hidden')
                $("#message").css("box-shadow","");
                $(".error").css('visibility', 'hidden');
            $('.all-message').fadeIn();
        else
            $('.all-message').fadeOut();
        return

    # 未読アイコン(赤)をクリックした時
    $('.unread-icon img.unread-icon').click ->
        unread_receive()    # 未読のメッセージを探しに行く
        return

    # 返信未読アイコン(緑)をクリックした時
    $('.unread-icon img.unread-reply-icon').click ->
        window.location.href = '/home/message/' + messageid # 該当メッセージへ遷移
        return

    # 返信メッセージを探しに行く
    reply_receive = ->
        if window.location.href.match(/\/home\/main/)   # メインページに居る時のみ
            $.ajax(url: location.href + '.json').done((json) ->
                if json.dst_id == json.user_id  # 自身のユーザIDと宛先ユーザIDが同じとき
                    messageid = json.id # そのメッセージのIDを取得
                    $('.unread-reply-icon').fadeIn(); # 返信未読アイコンを表示
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
                $('.send-info').css('background', 'rgba(94,145,205,0.2)');
                $('.send-info p').html("みつからなかったみたい");
                $('.send-info').fadeIn();
                $('.send-info').delay(1500).fadeOut();
            return
        ).fail (json) ->
            return
        return

    $ ->
        # 定期的に返信が来ていないか10秒毎に確認
        reply_receive()
        setInterval reply_receive, 10000
        return
    return


# メッセージを送った時に成功 or 失敗
$(document).on 'ajax:success', '#message_form', (e) ->
    console.log e.detail[0]
    $('textarea#message').val ''
    $('.send-info').css('background', 'rgba(94,145,205,0.2)');
    $('.send-info p').html("めっせーじ を おくりました");
    $('.send-info').fadeIn();
    $('.send-info').delay(1500).fadeOut();
    return
$(document).on 'ajax:error', '#message_form', (e) ->
    console.log e.detail[2]
    $('.send-info').css('background', 'rgba(212,93,135,0.2)');
    $('.send-info p').html("めっせーじ を おくれませんでした");
    $('.send-info').fadeIn();
    $('.send-info').delay(1500).fadeOut();
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
