class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'You have succesfully logged in'
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Access denied'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've succesfully logout out"
    redirect_to root_path
  end
end
