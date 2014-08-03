class CreateProjectsUsersRelation < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end
