class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :previous_activity
      t.integer :duration
      t.references :user
      t.string :user_name
      t.boolean :is_background
      t.timestamps
    end
  end
end
