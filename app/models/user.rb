class User < ActiveRecord::Base
  has_and_belongs_to_many :projects

  # Regular Expression to validate emails:
  # regex = []
  # regex << beginning_of_string = "/\A"
  # regex << email_identifier    = "([^@\s]+)"
  # regex << email_ad            = "@"
  # regex << email_domain        = "((?:[-a-z0-9]+\.)+"
  # regex << email_tld           = "[a-z]{2,})"
  # regex << end_of_string       = "\z/"
  # regex << case_insensitive    = "i"
  # EMAIL_REGEX = regex.join('')

  validates :email, presence: true, uniqueness: true

  # uncomment to validate if the emails are well formed
  # I would usually recommend to send activation emails and not to try to
  # match the pattern "email" - it is too error prone.
  # a simple matching like "includes an @ and a . and some charachters around them" is ok
  # validates_format_of :email, with: /#{EMAIL_REGEX}/, on: :update
end
