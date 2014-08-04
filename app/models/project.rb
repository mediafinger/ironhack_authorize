class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many                :tasks

  validates :name,   presence: true

  def self.visible_to(user)
    if user.admin? || user.po?
      Project.all
    elsif user.developer?
      user.projects
    end
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
