class CreateJobActivities < ActiveRecord::Migration
  def change
    create_table :job_activities do |t|
      t.references :job
      t.integer :previous_activity
      t.integer :duration
      t.references :user
      t.date :start_date
      t.date :end_date
      t.string :user_name
      t.boolean :is_background
      t.string :remark
      t.timestamps
    end
  end
end
