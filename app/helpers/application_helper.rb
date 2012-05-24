module ApplicationHelper
  def user_loggin_in?
    !session[:user].blank?
  end

  def current_user
    session[:user]
  end
end
