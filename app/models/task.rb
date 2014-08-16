class Task < ActiveRecord::Base
  include Activities

  belongs_to :project
  belongs_to :user

  validates :name,    presence: true
  validates :project, presence: true
  validates :user,    presence: true
  validates :status,  inclusion: { in: %w(todo doing done), message: "%{value} is not a valid status" }

  scope :todo,  -> { where(status: "todo")  }
  scope :doing, -> { where(status: "doing") }
  scope :done,  -> { where(status: "done")  }

  private

  def activity_data
    { name: name, status: status, user: user.try(:email) || "n/a" }
  end
end
