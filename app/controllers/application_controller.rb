class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required
  before_action :require_admin


  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
