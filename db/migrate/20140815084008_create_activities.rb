class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user
      t.string     :action
      t.text       :event
      t.datetime   :occured_at

      t.timestamps
    end
  end
end
