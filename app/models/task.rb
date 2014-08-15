class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many   :activities

  after_create :create_activity
  after_update :update_activity

  validates :name,    presence: true
  validates :project, presence: true
  validates :user,    presence: true
  validates :status,  inclusion: { in: %w(todo doing done), message: "%{value} is not a valid status" }

  scope :todo,  -> { where(status: "todo")  }
  scope :doing, -> { where(status: "doing") }
  scope :done,  -> { where(status: "done")  }

  private

  def create_activity
    CreateActivityJob.new.perform(
      user: user,
      task: self,
      action: :created,
      occured_at: Time.now
    )
  end

  def update_activity
    CreateActivityJob.new.perform(
      user: user,
      task: self,
      action: :updated,
      occured_at: Time.now
    )
  end
end
