class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :maid_id
      t.integer :client_id
      t.string :frequency
      t.string :day_of_week
      t.integer :length_of_time

      t.timestamps
    end
  end
end
