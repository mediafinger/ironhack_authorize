class InactiveTasksJob
  include SuckerPunch::Job
  workers 2

  def perform(user: user, inactivity: 7.days)
    ::InactiveTasksService.new(user: user).warn
  end
end
