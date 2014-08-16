module Activities
  extend ActiveSupport::Concern

  included do
    after_create  :create_activity
    after_update  :update_activity
    after_destroy :destroy_activity
  end

  def create_activity
    CreateActivityJob.new.perform(params_hash.merge(action: :created))
  end

  def update_activity
    CreateActivityJob.new.perform(params_hash.merge(action: :updated))
  end

  def destroy_activity
    CreateActivityJob.new.perform(params_hash.merge(action: :deleted))
  end

  private

  # this params are used every time an Activity is created
  def params_hash
    {
      item_type:  self.class.to_s.downcase, # the including class
      item_id:    self.id,                  # the id of the including item
      user_id:    user_id,                  # every including class needs to define user_id, when it is not an attribute
      occured_at: Time.now,
      options:    activity_data             # every including class needs to define activity_data, can be empty Hash
    }
  end
end
