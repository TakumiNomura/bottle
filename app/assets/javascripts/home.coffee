# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    ((w, d, b) ->
      h = w.innerHeight
      u = d.documentElement.scrollTop or b.scrollTop
      e = u - 10
      z = 9999
      i = 0
      p = 0
      t = new Array
      l = new Array
      y = new Array
      s = new Array
      g = new Array
      c = new Array
      q = d.createElement('div')
      css = '.bubble{' + 'position:absolute;' + 'transform: translate3d(0,0,0);' + 'background:rgba(255,255,255,0.1);' + 'border-radius:8px;' + 'box-shadow: 0 0 1px 2px rgba(255,255,225,0.2);' + '}' + '.bubble::after{' + 'content:"";' + 'display:block;' + 'height:4px;' + 'width:4px;' + 'border-radius:2px;' + 'background:rgba(255,255,255,0.3);' + '}'
      q.innerHTML = '<style>' + css + '</style>'
      q.id = 'bubbleparticle'
      b.appendChild q
      q = d.getElementById('bubbleparticle')
      b.style.overflowX = 'hidden'

      ###スクロールとリサイズ時のイベント ###

      d.addEventListener 'scroll', (->
        u = d.documentElement.scrollTop or b.scrollTop
        return
      ), false
      w.addEventListener 'resize', (->
        u = d.documentElement.scrollTop or b.scrollTop
        h = w.innerHeight
        return
      ), false

      ###泡用の div を50個用意 ###

      i = 0
      while i < 30
        m = d.createElement('div')
        m.id = 'awa' + i
        t[i] = Math.random() * (h + u) + u

        ### 泡の発生位置、top ###

        l[i] = Math.random() * w.innerWidth

        ### 泡の発生位置、left###

        p = Math.random() * 8 + 6

        ### 泡のサイズ ###

        m.setAttribute 'style', 'z-index:' + z + i + ';top:' + t[i] + 'px;width:' + p + 'px;height:' + p + 'px;left:' + l + 'px;'
        m.setAttribute 'class', 'bubble'
        q.appendChild m
        y[i] = Math.random() * 25 + 0.1

        ### ゆらぐ最大値 ###

        s[i] = Math.random() * 5 + 3.5

        ### 上昇速度最大値 ###

        g[i] = d.getElementById('awa' + i)
        c[i] = 0
        i++

      setLeft = ->
          if Math.round(Math.random() * 1)
              Math.random() * o
          else
              Math.random() * (w.innerWidth - n) + n


      ###泡をアニメーションさせるループ ###

      setInterval (->
        i = 0
        while i < 30
          if u < t[i]
            if y[i] >= c[i]
              l[i] = l[i] + 0.5 + Math.random() * 0.5
            else
              l[i] = l[i] - 0.5 - (Math.random() * 0.5)
            if y[i] * 2 <= c[i]
              c[i] = 0
          else
            t[i] = u + h - 16
            l[i] = Math.random() * w.innerWidth
          t[i] = t[i] - (s[i])
          g[i].style.top = t[i] + 'px'
          g[i].style.left = l[i] + 'px'
          c[i]++
          i++
        return
      ), 45
      return
    ) window, document, document.body




    if window.location.href.match(/\/home\/main/)
        ta = document.getElementById('message')
        ta.style.lineHeight = '30px'
        #init
        ta.style.height = '150px'
        #init
        ta.addEventListener 'input', (evt) ->
            if evt.target.scrollHeight > evt.target.offsetHeight
                evt.target.style.height = evt.target.scrollHeight + 'px'
            else
                height = undefined
                lineHeight = undefined
            # 1行目から小さくする場合
            '''
            loop
                height = Number(evt.target.style.height.split('px')[0])
                lineHeight = Number(evt.target.style.lineHeight.split('px')[0])
                evt.target.style.height = height - lineHeight + 'px'
                if evt.target.scrollHeight > evt.target.offsetHeight
                    evt.target.style.height = evt.target.scrollHeight + 'px'
                    break
            '''
            return
    return
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

# ボタン・ボトルをクリックした時、投稿一覧外の領域をクリックした時の処理
$(document).on 'click touchend', (e) ->
    $('.button-wrap .button').click ->
        if $(this).find('a').attr('target') == '_blank'
            window.open $(this).find('a').attr('href'), '_blank'
        else
            window.location = $(this).find('a').attr('href')
        false

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
    return
