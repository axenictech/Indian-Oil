class AddStatusTgsoJobActivity < ActiveRecord::Migration
  def change
    change_column :job_activities, :status, :string, default: 'CREATED'
  end
end
