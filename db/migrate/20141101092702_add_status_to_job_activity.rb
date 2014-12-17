class AddStatusToJobActivity < ActiveRecord::Migration
  def change
    add_column :job_activities, :status, :string, default: "PENDING"
  end
end
