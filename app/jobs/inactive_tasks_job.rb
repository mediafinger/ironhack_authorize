class InactiveTasksJob
  include SuckerPunch::Job
  workers 2

  def perform(user: user, inactivity: 7.days)
    ActiveRecord::Base.connection_pool.with_connection do
      ::InactiveTasksService.new(user: user).warn
    end
  end
end
