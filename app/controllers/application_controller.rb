class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    redirect_to new_session_url, alert: "Not logged in" if current_user.nil?
  end

  def set_session(user)
    session[:token] = user.set_session_token
  end

  def current_user
    if session[:token]
      @current_user ||= User.find_by_session_token(session[:token])
    end
  end
  helper_method :current_user   # to be able to use it from the views
end
