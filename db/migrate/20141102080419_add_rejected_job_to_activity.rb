class AddRejectedJobToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :rejected_activity, :integer
    add_column :job_activities, :rejected_activity, :integer
  end
end
