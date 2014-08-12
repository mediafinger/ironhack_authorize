class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to projects_path, notice: "Welcome back!"
    else
      flash[:notice] = "Email or password is invalid."
      render :new
    end
  end


  private

    def session_params
      params.permit(:email, :password)
    end
end
