# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every :day, at: '4am' do
  runner ::InactiveTasksUsersJob.new.async.perform(users: User.all, inactivity: 7.days)
end

every :sunday, at: '2am' do
  runner ::InactiveTasksDeleteJob.new.async.perform(users: User.all, inactivity: 14.days)
end


# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
