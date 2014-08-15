class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :action, :occured_at, :user, presence: true
end
