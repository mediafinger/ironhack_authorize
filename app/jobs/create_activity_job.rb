class CreateActivityJob
  include SuckerPunch::Job
  workers 2

  def perform(
      action:     action,
      item_type:  item_type,
      item_id:    item_id,
      user_id:    user_id,
      occured_at: occured_at,
      options:    {}
    )

    ActiveRecord::Base.connection_pool.with_connection do
      Activity.create(
        action:     action,
        item_type:  item_type,
        item_id:    item_id,
        user_id:    user_id,
        occured_at: occured_at,
        event:      options
      )
    end
  end
end
