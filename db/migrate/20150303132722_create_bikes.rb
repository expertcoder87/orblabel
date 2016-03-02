class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :brand
      t.string :model
      t.integer :size
      t.date :building_date
      t.string :serial_number
      t.string :certification

      t.timestamps null: false
    end
  end
end
