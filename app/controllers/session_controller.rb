class SessionController < ApplicationController
  skip_before_action :authenticate

  def new
  end

  def create
    user = User.where(:username => params[:username]).first
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path, :notice => 'Incorrect username or password, please try again'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
end