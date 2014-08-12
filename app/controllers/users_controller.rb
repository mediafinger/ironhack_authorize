class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    token = SecureRandom.urlsafe_base64(24)
    @user = User.new(user_params.merge(confirmation_token: token))

    if @user.save
      session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user).deliver
      redirect_to projects_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def confirm
    user = User.find_by_confirmation_token(params[:confirmation_token])

    if user
      user.update_attributes!(confirmation_token: nil, confirmed: true)  # one time token - not needed anymore
      session[:user_id] = user.id     # we log the user in without asking for his password
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
