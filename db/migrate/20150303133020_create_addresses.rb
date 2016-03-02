class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :zipcode
      t.string :city
      t.string :state
      t.timestamps null: false
    end
  end
end
