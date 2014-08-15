class Activity < ActiveRecord::Base
  belongs_to :user

  serialize :event, Hash

  validates :action, :occured_at, :user, presence: true
end
