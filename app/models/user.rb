class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many                :tasks

  # has_secure_password is a Rails helper
  # it comes with an attr_accessor for :password, that's why we removed it
  # it also triggers some validations on password, as we wrote the validations already,
  # we pass the parameter false to the helper
  has_secure_password validations: false

  # has_secure_password uses Bcrypt to generate hashed and salted passwords
  # doing this manually could look like this:
  # require 'digest/sha1'
  # salt = Digest::SHA1.hexdigest("Add #{email} as unique value and #{Time.now} as random value")
  # encrypted_password = Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
  # you would need to save the salt and the encrypted_password in the database

  # very simple email matcher ~ "includes an @ and a . and some charachters around them"
  # real email validation will happen over activation email
  validates :email, presence: true, uniqueness: true, format: /\S+@\S+\.\S+/
  validates :password, length: { minimum: 4 }, on: :create
  validates :password, confirmation: true

  def confirm!
    # one time token is not needed anymore, but we have to save that email is confirmed
    update_attributes!(confirmation_token: nil, confirmed: true)
    # optional: send email ...
  end

  def set_session_token
    update_attributes(session_token: SecureRandom.urlsafe_base64(24))
    return session_token
  end

end
