class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string     :action
      t.string     :item_type
      t.integer    :item_id
      t.integer    :user_id
      t.text       :event
      t.datetime   :occured_at

      t.timestamps
    end
  end
end
