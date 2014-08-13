class InactiveTasksService

  def initialize(user:, inactivity: 7.days)
    @user     = user
    @deadline = Date.today - inactivity
  end

  def inactive_tasks
    @user.tasks.where("tasks.updated_at < ?", @deadline)
  end

  def warn
    if inactive_tasks.present?
      ::InactiveTasksWarningJob.new.async.perform(user: @user, tasks: inactive_tasks)
    end
  end

  def delete
    inactive_tasks.destroy_all
  end
end
