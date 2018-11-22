class HomeController < ApplicationController
  # before_action :authenticate_user!
  def top
#     if user_signed_in?
#       redirect_to "/home/main"
#     end
  end

  def main
      # メッセージ表示から戻ってきた時以外はローディングアニメーションを表示
      @path = Rails.application.routes.recognize_path(request.referer)
      if @path[:action] == "message"    # 前のページがmessageアクションだった場合
          @loading = false
      else
          @loading = true
      end

      respond_to do |format|
          format.html {
              @user = current_user.id
          } # html形式でアクセスがあった場合
          format.json {
              @user = current_user.id
              @user_id = Integer(@user)
              # 未読メッセージ：既読フラグがfalse かつ 自分が送っていない かつ 宛先が存在しないもの で最古のもの
              @unread_all = Post.where("read_flag is false").where.not(src_id: @user_id).where(dst_id: nil)
              @unread = @unread_all.first
              # 返信メッセージ：既読フラグがfalse かつ 宛先が自分のID で最古のもの
              @reply_all = Post.where("read_flag is false").where(dst_id: @user_id)
              @reply = @reply_all.first
          } # json形式でアクセスが有った場合
      end
  end

  # 通常のメッセージ投稿
  def create
    @post = Post.new(message:params[:message], src_id: current_user.id)
    if !@post.save
        render :new, notice: "Error"
    end
  end

  # 返信する際
  def reply
      @replyto = Post.find(params[:id])
      @reply = Post.new(message:params[:message], read_flag:"false", src_id: current_user.id, dst_id: @replyto.src_id)
      if !@reply.save
          render :new, notice: "Error"
      end
  end

  # メッセージ詳細表示
  def message
    @message = Post.find(params[:id])
    @message.update(read_flag: true)   # 開いたら既読に
  end


end
