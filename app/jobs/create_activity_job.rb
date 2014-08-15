class CreateActivityJob
  include SuckerPunch::Job
  workers 2

  def perform(user: user, action: action, occured_at: occured_at, options: {})
    ActiveRecord::Base.connection_pool.with_connection do
      Activity.create(user: user, action: action, occured_at: occured_at,
        event: options
      )
    end
  end
end
