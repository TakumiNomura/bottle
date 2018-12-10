class HomeController < ApplicationController
  # before_action :authenticate_user!
  def top
#     if user_signed_in?
#       redirect_to "/home/main"
#     end
  end

  def main
      # メッセージ表示から戻ってきた時以外はローディングアニメーションを表示
      respond_to do |format|
          # ユーザごとに保存されているメッセージを取得
          @message_all = Receive.where(u_id: current_user.id).order(created_at: "DESC")
          @message = @message_all.map{|post| Post.find(post.mes_id)}

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
      # 過去の履歴を取得
      if @replyto.anc_id.nil?
          @reply = Post.new(message:params[:message], read_flag:"false", src_id: current_user.id, dst_id: @replyto.src_id, anc_id: @replyto.id)
      else
          @reply = Post.new(message:params[:message], read_flag:"false", src_id: current_user.id, dst_id: @replyto.src_id, anc_id: @replyto.anc_id)
      end
      # 返信したらフラグを立てる
      @message_replyed = Receive.find_by(u_id: current_user.id, mes_id: @replyto.id)
      @message_replyed.update(reply_flag: true)
      if !@reply.save
          render :new, notice: "Error"
      end
  end

  # メッセージ詳細表示
  def message
      if request.referer.nil?
          redirect_to "/home/main"
      end
      @message = Post.find(params[:id])
      @message.update(read_flag: true, dst_id: current_user.id)   # 開いたら既読に
      @receive = Receive.new(u_id: current_user.id, mes_id: @message.id)
      if Receive.where(mes_id: @message.id).empty?
          @receive.save
      end
      if @message.anc_id.present?
          @message_history = (Post.where(anc_id: @message.anc_id).or(Post.where(id: @message.anc_id))).order(created_at: "ASC")
      end
      # 返信フラグがtrueのときは返信できない
      @message_replyed = Receive.find_by(u_id: current_user.id, mes_id: @message.id)
  end

  def destroy
      @message = Receive.find_by(mes_id: params[:id])
      @message.destroy
  end

end
