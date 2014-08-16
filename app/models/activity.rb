class Activity < ActiveRecord::Base
  serialize :event, Hash

  validates :action, :occured_at, :item_type, presence: true
end
