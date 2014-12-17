class AddRejectorIdToJobActivity < ActiveRecord::Migration
  def change
    add_column :job_activities, :rejector_id, :integer
  end
end
