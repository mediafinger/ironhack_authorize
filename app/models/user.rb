class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many                :tasks

  attr_accessor :password

  # very simple email matcher ~ "includes an @ and a . and some charachters around them"
  # real email validation will happen over activation email
  validates :email, presence: true, uniqueness: true, format: /\S+@\S+\.\S+/
  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
end
