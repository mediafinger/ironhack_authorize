class CreateTask < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string  :name
      t.string  :status
      t.timestamps
    end
  end
end
