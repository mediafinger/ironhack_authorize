class InactiveTasksWarningJob
  include SuckerPunch::Job
  workers 2

  def perform(user:, tasks:)
    ActiveRecord::Base.connection_pool.with_connection do
      ::UserMailer.inactive_tasks_warning(user, tasks).deliver
    end
  end
end
