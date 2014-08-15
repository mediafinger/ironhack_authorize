class UsersController < ApplicationController

  before_filter :redirect_if_logged_in, only: [:new, :create, :confirm]
  skip_before_filter :authenticate, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    token = SecureRandom.urlsafe_base64(24)
    @user = User.new(user_params.merge(confirmation_token: token))

    if @user.save
      set_session(@user)
      UserMailer.signup_confirmation(@user).deliver
      redirect_to projects_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def confirm
    user = User.find_by_confirmation_token(params[:confirmation_token])

    if user
      user.confirm!
      set_session(user)    # we log the user in without asking for his password
      redirect_to projects_path, notice: 'Your confirmed your email!'
    else
      redirect_to new_session_path, notice: 'Token not valid'
    end
  end


  private

    def user_params
      params[:user].permit(:email, :password, :password_confirmation)
    end

end
