class InactiveTasksUsersJob
  include SuckerPunch::Job
  workers 2

  def perform(users: users, inactivity: 7.days)
    users.each do |user|
      ::InactiveTasksJob.new.async.perform(user: user, inactivity: inactivity)
    end
  end
end
