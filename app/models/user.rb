class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many                :tasks
  has_many                :activities

  ROLES = %w[admin developer po]
  serialize :roles, Array      # we want to use this string field like an Array

  has_secure_password validations: false

  # very simple email matcher ~ "includes an @ and a . and some charachters around them"
  # real email validation will happen over activation email
  validates :email, presence: true, uniqueness: true, format: /\S+@\S+\.\S+/
  validates :password, length: { minimum: 4 }, on: :create
  validates :password, confirmation: true
  validate  :validate_roles

  def confirm!
    # one time token is not needed anymore, but we have to save that email is confirmed
    update_attributes!(confirmation_token: nil, confirmed: true)
  end

  def set_session_token
    update_attributes(session_token: SecureRandom.urlsafe_base64(24))
    return session_token
  end

  # setter that encapsulates logic and validation for the serialized field
  def add_role(role)
    update_attributes!(roles: Array(roles) + Array(role.to_s.downcase))
  end

  # setter that encapsulates logic and validation for the serialized field
  def remove_role(role)
    update_attributes!(roles: Array(roles) - Array(role.to_s.downcase))
  end

  def admin?
    roles.include? "admin"
  end

  def developer?
    roles.include? "developer"
  end

  def po?
    roles.include? "po"
  end


  private

  def validate_roles
    roles.each do |role|
      errors.add(:role, "#{role} is listed multiple times") unless roles.count(role) <= 1
      errors.add(:role, "#{role} is no a valid role") unless ROLES.include? role
    end
  end

end
