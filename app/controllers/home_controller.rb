class HomeController < ApplicationController
  def top
  end

  def main
  end

  def create
    @post = Post.new(message:params[:message])
    @post.save
  end

end
