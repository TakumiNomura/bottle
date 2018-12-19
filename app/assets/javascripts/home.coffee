# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# ローディングアニメーション
stopload = ->
    $('.loading').delay(1000).fadeOut 400
    if window.location.href.match(/\/home\/loading/)
        window.location.href = '/home/main'
        return

$(window).on 'load', ->
    # ロードし終わったらローディング画面をフェードアウト
    $('.loading').delay(1000).fadeOut 400
    if window.location.href.match(/\/home\/loading/)
        window.location.href = '/home/main'
        return

$ ->
    # テキストエリアを選択状態にする
    $('.message-wrap .textbox').focus();
    # 連続で投稿できないようにする
    form = $('#message_form')
    form.submit (event) ->
        $(':input[type="image"]').prop('disabled', true);   # 投稿ボタンを無効化
        # 投稿中メッセージ
        # message = $('<div class="please-wait">Please Wait...</div>')
        # form.append message
        return

    $ ->
        #ボトルにマウスを乗せたら
        $('input#send').hover (->
            if $('input#send').css('opacity') != '0'
                $('.message-wrap .textbox').addClass('hover')
                $('input#send')
                  .addClass('hover')
                  .addClass('swing')
            return
        ), ->
            $('input#send').removeClass('swing')
            return
        return

    messageid = ''  # 返信できたメッセージID格納用

    # 書き込みボタンをクリックした時、表示・非表示切り替え
    $('.icon-wrap #write').click ->
        if $('.message-wrap .textbox').hasClass('display')
            # 非表示に切り替え
            $('.message-wrap .textbox')
                .removeClass('display')
                .addClass('hidden')  # テキストエリアを非表示
                .removeClass('hover')
            $('.icon-wrap #write .caption').html("かく")  # アイコンの文字をかくに
            $('input#send') # ボトルのアイコンを消す
                .removeClass('hover')
                .css("cursor","initial");
        else
            # 表示に切り替え
            if $('.all-message').css('display') == 'block'
                # 手持ちメッセージを表示してる時は消す
                $('.all-message').fadeOut()
            $("#message").css("box-shadow","")      # エラー枠が出ていたときは消す
            $(".error").css('visibility', 'hidden') # エラー文が出ていた時は消す
            $('.message-wrap .textbox')
                .removeClass('hidden')
                .addClass('display')    # テキストエリアを表示
                .focus()                # テキストエリアを選択状態にする
            $('.icon-wrap #write .caption').html("とじる") # アイコンの文字をとじるに
            $('.icon-wrap #bag .caption').html("みる")  # アイコンの文字をみるに
            $('input#send').css("cursor","pointer");    # ボトルにカーソルをあわせた時
        return

    # かばんボタンをクリックした時、表示・非表示切り替え
    $('.icon-wrap #bag').click ->
        if $('.all-message').css('display') == 'none'
            if $('.message-wrap .textbox').hasClass('display')
                $('.message-wrap .textbox')
                    .removeClass('display')
                    .addClass('hidden')
                $('.icon-wrap #write .caption').html("かく")  # アイコンの文字をかくに
                $("#message").css("box-shadow","");
                $(".error").css('visibility', 'hidden');
            $('.all-message').fadeIn();
            $('.icon-wrap #bag .caption').html("とじる")  # アイコンの文字をとじるに
        else
            $('.all-message').fadeOut();
            $('.icon-wrap #bag .caption').html("みる")  # アイコンの文字をみるに
        return

    # 未読アイコン(赤)をクリックした時
    $('.unread-icon img.unread-icon').click ->
        unread_receive()    # 未読のメッセージを探しに行く
        return

    # 返信未読アイコン(緑)をクリックした時
    $('.unread-icon img.unread-reply-icon').click ->
        window.location.href = '/home/message/' + messageid # 該当メッセージへ遷移
        return

    # 削除ボタンをクリックした時
    $('.all-message .message p#delete').click ->
        messageno = $(this).parent().parent().data('message-no')
        messageitem = $(this).parent().parent()
        delete_message(messageno, messageitem)
        return

    # 手持ちメッセージの削除
    delete_message = (messageno, messageitem) ->
        $.ajax(url: '/home/receives/' + messageno, type: 'DELETE').done((json) ->
            $('.send-info p').html("めっせーじを さくじょしました");
            $('.send-info')
                .css('background', 'rgba(94,145,205,0.2)')
                .fadeIn()
                .delay(1500)
                .fadeOut();
            $(messageitem).remove()
            return
        ).fail (json) ->
            $('.send-info p').html("めっせーじの さくじょにしっぱいしました");
            $('.send-info')
                .css('background', 'rgba(212,93,135,0.2)')
                .fadeIn()
                .delay(1500)
                .fadeOut();
            return
        return

    # 返信メッセージを探しに行く
    reply_receive = ->
        if window.location.href.match(/\/home\/main/)   # メインページに居る時のみ
            $.ajax(url: location.href + '.json').done((json) ->
                if json.dst_id == json.user_id  # 自身のユーザIDと宛先ユーザIDが同じとき
                    messageid = json.id # そのメッセージのIDを取得
                    $('.back-img img.cat#off').hide();
                    $('.back-img img.cat#on').show();
                    $('.unread-reply-icon').show(); # 返信未読アイコンを表示
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
                $('.send-info p').html("みつからなかったみたい");
                $('.send-info')
                    .css('background', 'rgba(94,145,205,0.2)')
                    .fadeIn()
                    .delay(1500)
                    .fadeOut();
            return
        ).fail (json) ->
            return
        return

    $ ->
        # 定期的に返信が来ていないか15秒毎に確認
        reply_receive()
        setInterval reply_receive, 15000
        return
    return


# メッセージを送った時に成功 or 失敗
$(document).on 'ajax:success', '#message_form', (e) ->
    console.log e.detail[0]
    $('textarea#message').val ''
    $('.send-info p').html("めっせーじ を おくりました");
    $('.send-info')
        .css('background', 'rgba(94,145,205,0.2)')
        .fadeIn()
        .delay(1500)
        .fadeOut();
    $(':input[type="image"]').prop('disabled', false);  # 投稿ボタンを有効化
    if window.location.href.match(/\/home\/message\/[0-9]*/)    # メッセージ詳細画面にいる時はメインページへ
        setTimeout (->
            window.location.href = '/home/main'
            return
            ), 1500
    return
$(document).on 'ajax:error', '#message_form', (e) ->
    console.log e.detail[2]
    $('.send-info p').html("めっせーじ を おくれませんでした");
    $('.send-info')
        .css('background', 'rgba(212,93,135,0.2)')
        .fadeIn()
        .delay(1500)
        .fadeOut();
    $(':input[type="image"]').prop('disabled', false);  # 投稿ボタンを有効化
    if window.location.href.match(/\/home\/message\/[0-9]*/)    # メッセージ詳細画面にいる時はメインページへ
        setTimeout (->
            window.location.href = '/home/main'
            return
            ), 1500
    return

$(document).on 'ajax:success', '#report', (e) ->
    $('.send-info p').html("つうほう しました");
    $('.send-info')
        .css('background', 'rgba(94,145,205,0.2)')
        .fadeIn()
        .delay(1500)
        .fadeOut();
    setTimeout ->
       window.location = "/home/main";
    , 2100
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
