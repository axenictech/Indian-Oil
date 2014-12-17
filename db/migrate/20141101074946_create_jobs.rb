class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :current_status
      t.string :current_owner
      t.integer :present_activity
      t.timestamps
    end
  end
end
