class HomeController < ApplicationController

  def top
      respond_to do |format|
          @post_all = Post.where("read_flag is false") #.pluck(:message)
          @post_new = @post_all.last
          format.html # html形式でアクセスがあった場合は特に何もなし
          format.json
      end
  end

  def main
      respond_to do |format|
          @post_all = Post.where("read_flag is false") #.pluck(:message)
          @post_new = @post_all.last
          format.html # html形式でアクセスがあった場合は特に何もなし
          format.json
      end
  end

  def create
    @post = Post.new(message:params[:message], read_flag:"false")
    if !@post.save
        render :new, notice: "Error"
    end
  end

  def message
    @message = Post.find(params[:id])
    @message.update(read_flag: true)
  end

end
