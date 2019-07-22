class CreateCounsellings < ActiveRecord::Migration[5.2]
  def change
    create_table :counsellings do |t|
      t.text :note
      t.date :counselling_date
      t.references :candidate

      t.timestamps
    end
  end
end
