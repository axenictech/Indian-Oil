class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :holiday
      t.timestamps
    end
  end
end
