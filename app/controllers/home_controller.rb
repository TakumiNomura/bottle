class HomeController < ApplicationController
  # before_action :authenticate_user!
  def top
#     if user_signed_in?
#       redirect_to "/home/main"
#     end
  end

  def main
      @path = Rails.application.routes.recognize_path(request.referer)
      if @path[:action] == "message"
          @loading = false
      else
          @loading = true
      end
      respond_to do |format|
          format.html {
              @user = current_user.id
          }# html形式でアクセスがあった場合は特に何もなし
          format.json {
              @user = current_user.id
              @user_id = Integer(@user)
              @post_all = Post.where("read_flag is false")
              @post_new = @post_all.first
          }
      end
  end

  def create
    @post = Post.new(message:params[:message], read_flag:"false", src_id: current_user.id)
    if !@post.save
        render :new, notice: "Error"
    end
  end

  def message
    @message = Post.find(params[:id])
    @message.update(read_flag: true, dst_id: current_user.id)
  end


end
