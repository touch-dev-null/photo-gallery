class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def gallery_single_mode?
    APP_CONFIG['gallery_mode'].eql?('single')
  end

  def authenticate_user!
    redirect_to signin_path unless current_user
  end

  def current_user
    return session[:user].blank? ? nil : session[:user]
  end
end
