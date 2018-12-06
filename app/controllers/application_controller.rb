class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception
#   before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    '/home/loading'
  end

#   def after_sign_out_path_for(resource)
#     flash[:alert] = "ログアウトしました"
#     '/home/top'
#   end

  def set_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
