class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or root_url
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out_user
    redirect_to root_url
  end

  def new
    @title = 'Log in'
  end
  
end