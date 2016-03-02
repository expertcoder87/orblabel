class CreateCertifiedBikes < ActiveRecord::Migration
  def change
    create_table :certified_bikes do |t|
      t.string :email
      t.string :email_confirmation
      t.string :selling_price

      t.timestamps null: false
    end
  end
end
