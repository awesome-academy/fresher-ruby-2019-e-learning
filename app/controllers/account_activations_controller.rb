class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login user
      redirect_to user
    else
      flash[:danger] = t ".not_activation"
      redirect_to root_url
    end
  end
end
