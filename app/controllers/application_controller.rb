class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_member

  private
  def current_member
    @current_member ||= Member.find_by_uid(session[:uid]) if session[:uid]
  end

  def authorize
    unless session[:uid]
      flash[:notice] = t(:must_login)
      redirect_to root_path
    end
  end
end
