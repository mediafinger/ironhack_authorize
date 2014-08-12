class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to projects_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end


  private

    def user_params
      params[:user].permit(:email, :password, :password_confirmation)
    end
end
