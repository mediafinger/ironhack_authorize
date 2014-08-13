class InactiveTasksWarningJob
  include SuckerPunch::Job
  workers 4

  def perform(user:, tasks:)
    ::UserMailer.inactive_tasks_warning(user, tasks).deliver
  end

  def later(delay: 600, user:, tasks:)
    after(delay) { perform(user: user, tasks: tasks) }
  end
end
