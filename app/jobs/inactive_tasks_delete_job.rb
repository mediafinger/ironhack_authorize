class InactiveTasksDeleteJob
  include SuckerPunch::Job
  workers 2

  def perform(user: user, inactivity: 14.days)
    ::InactiveTasksService.new(user: user).delete
  end
end
