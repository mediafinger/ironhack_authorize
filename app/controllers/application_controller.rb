class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :authenticate

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    user_locale = params[:locale] || cookies[:locale]
    set_cookie(user_locale)
    I18n.locale = check_availability(user_locale)  || I18n.default_locale
  end

  # refactor me, please!
  def set_cookie(locale)
    if locale
      cookies[:locale] = locale
    else
      cookies[:locale] = nil
    end

    locale
  end

  # better set I18n.available_locales = ['en', 'es']
  # and work with this variable, than having an anonymous random array somewhere in the code
  def check_availability(locale)
    if ['en', 'es'].include? locale.to_s
      locale
    else
      false
    end
  end

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

  def redirect_if_logged_in
    if current_user
      redirect_to projects_path, notice: "You are already logged in!"
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = "You cannot perform the action #{exception.query} according to the #{policy_name}."
    redirect_to(request.referrer || root_path)
  end
end
