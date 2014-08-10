class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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


  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = "You cannot perform the action #{exception.query} according to the #{policy_name}."
    redirect_to(request.referrer || root_path)
  end
end
