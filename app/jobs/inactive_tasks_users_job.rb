class InactiveTasksUsersJob
  include SuckerPunch::Job
  workers 2

  def perform(users: users, inactivity: 7.days)
    ActiveRecord::Base.connection_pool.with_connection do
      users.each do |user|
        ::InactiveTasksJob.new.async.perform(user: user, inactivity: inactivity)
      end
    end
  end
end
