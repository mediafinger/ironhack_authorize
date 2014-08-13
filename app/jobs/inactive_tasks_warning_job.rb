class InactiveTasksWarningJob
  include SuckerPunch::Job
  workers 2

  def perform(user:, tasks:)
    ::UserMailer.inactive_tasks_warning(user, tasks).deliver
  end
end
