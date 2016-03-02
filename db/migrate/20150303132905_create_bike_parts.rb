class CreateBikeParts < ActiveRecord::Migration
  def change
    create_table :bike_parts do |t|
      t.integer :type
      t.string :brand
      t.string :model
      t.date :building_date
      t.string :serial_number

      t.timestamps null: false
    end
  end
end
