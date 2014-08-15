class CreateActivityJob
  include SuckerPunch::Job
  workers 2

  def perform(user: user, task: task, action: action, occured_at: occured_at)
    ActiveRecord::Base.connection_pool.with_connection do
      Activity.create(user: user, task: task, action: action, occured_at: occured_at)
    end
  end
end
