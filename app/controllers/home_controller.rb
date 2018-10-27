class HomeController < ApplicationController
  def top
      @post_all = Post.where("read_flag is false").pluck(:message)
  end

  def main
  end

  def create
    @post = Post.new(message:params[:message], read_flag:"false")
    @post.save
  end

end
