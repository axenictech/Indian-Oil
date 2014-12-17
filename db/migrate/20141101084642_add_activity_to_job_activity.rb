class AddActivityToJobActivity < ActiveRecord::Migration
  def change
    add_column :job_activities, :activity_id, :integer, references: :activity
  end
end
