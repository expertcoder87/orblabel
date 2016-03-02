  class CreateStores < ActiveRecord::Migration
    def change
      create_table :stores do |t|
        t.string :public_name
        t.string :legal_name
        t.string :cnpj
        t.string :area_code
        t.string :phone_number
        t.string :responsible_name

        t.timestamps null: false
      end
    end
  end
