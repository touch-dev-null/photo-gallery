class UsersController < ApplicationController
  #before_filter :authenticate_user!, :except => [:signin]

  def signin
    if request.post?
      if params[:user].blank?
        render :layout => 'signin'
        return
      end

      user = User.find_by_login(params[:user][:login])
      if user && user.valid_password?(params[:user][:password])
        session[:user] = user
        redirect_to root_path
        return
      else
        flash[:error] = t('.invalid_login_or_password')
        #render :layout => 'signin'
        return
      end
    end

    #render :layout => 'signin'
  end

  def logout
    session[:user] = nil
    redirect_to root_path
  end
end
