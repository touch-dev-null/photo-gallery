class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_user!
    redirect_to admin_signin_path unless current_user
  end

  def current_user
    return session[:user].blank? ? nil : session[:user]
  end
end
