class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    '/home/main'
  end

  def after_sign_out_path_for(resource)
    flash[:alert] = "ログアウトしました"
    '/home/top'
  end
end
