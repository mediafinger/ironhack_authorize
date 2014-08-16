class Project < ActiveRecord::Base
  include Activities

  has_and_belongs_to_many :users
  has_many                :tasks, dependent: :destroy

  validates :name,   presence: true

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

  private

  def activity_data
    { name: name }
  end

  def user_id
    users.try(:first).try(:id)
  end
end
