class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.string     :action
      t.datetime   :occured_at

      t.timestamps
    end
  end
end
