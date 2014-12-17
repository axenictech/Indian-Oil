class AddNameToJobActivity < ActiveRecord::Migration
  def change
    add_column :job_activities, :name, :string
  end
end
