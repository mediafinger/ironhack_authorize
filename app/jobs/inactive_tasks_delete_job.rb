class InactiveTasksDeleteJob
  include SuckerPunch::Job
  workers 2

  # In the InactiveTasksUsersJob we call the InactiveTasksJob
  # here we call the service directly
  # The version here can lead to a very long running background job
  # (risk of running into a timeout)
  # So the other version is the better one!

  def perform(users: users, inactivity: 14.days)
    ActiveRecord::Base.connection_pool.with_connection do
      users.each do |user|
        ::InactiveTasksService.new(user: user).delete
      end
    end
  end
end
