class UsersController < ApplicationController

  before_filter :signed_in_user,    only: [:index, :edit, :update, 
                                           :show, :destroy]
  before_filter :correct_user,      only: [:edit, :update, :destroy]

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User created."
      redirect_to root_path
    else
      render 'users/new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
    @title = 'Edit User'
    @user = User.find(params[:id])
  end

  def index
    @title = 'Users'
    @users = User.page(params[:page]).per(10)
  end

  def new
    @title = 'New User'
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      sign_in @user
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
