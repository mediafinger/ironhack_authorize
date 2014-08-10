class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many                :tasks

  validates :name,   presence: true

  def self.visible_to(user)
    Pundit.policy_scope(user, Project.all)  # Project.all is a scope
  end

  def status
    statuses = tasks.pluck(:status).uniq

    if statuses.include? "todo"
      "todo"
    elsif statuses.include? "doing"
      "doing"
    elsif statuses.include? "done"
      "done"
    end
  end
end
