class SessionsController < ApplicationController

  def new
    redirect_to user_path(current_user) if logged_in
  end

  def create
    
    @user = User.find_by(name: params[:user][:name])

    if !!@user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "Can't find user. Re-check username and/or password."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
