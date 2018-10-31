class HomeController < ApplicationController
  def top

  end

  def main
      @post_all = Post.where("read_flag is false") #.pluck(:message)
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
