class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])  
      login user
      process_login user
      redirect_to current_user
    else
      flash[:danger] = t ".login_fail"
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end

  def process_login user
    params[:session][:remember_me] == Settings.remember_me ? remember(user) : forget(user)
  end
end
