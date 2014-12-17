class AddCapatityToActivity < ActiveRecord::Migration
  def change
    add_column :jobs, :capacity, :string

    add_column :activities, :activity_type, :string
    add_column :job_activities, :activity_type, :string
  end
end
