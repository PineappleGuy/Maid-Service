class CreateMaids < ActiveRecord::Migration[5.2]
  def change
    create_table :maids do |t|
      t.string :first_name
      t.string :last_name
      t.string :experience

      t.timestamps
    end
  end
end