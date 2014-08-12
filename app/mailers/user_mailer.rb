class UserMailer < ActionMailer::Base
  default from: "confirmation@example.com"

  def signup_confirmation(user)
    user_activation_link(user)

    @greeting = "Thank you for signing up"
    @email    = user.email

    mail to: @email
  end


  private

    def user_activation_link(user)
      token     = user.confirmation_token
      base_url  = AuthorizeApp::Application.config.base_url
      path      = "users/confirm"

      @link = "#{base_url}#{path}?confirmation_token=#{token}"
    end

end
