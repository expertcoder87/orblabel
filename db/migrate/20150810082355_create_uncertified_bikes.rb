class CreateUncertifiedBikes < ActiveRecord::Migration
  def change
    create_table :uncertified_bikes do |t|
      t.string :name
      t.integer :cpf
      t.string :email
      t.string :email_confirmation
      t.string :area_code
      t.string :cell_phone_number
      t.string :street
      t.string :number
      t.string :district
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :certification
      t.string :certification_confirm
      t.string :selling_price

      t.timestamps null: false
    end
  end
end
