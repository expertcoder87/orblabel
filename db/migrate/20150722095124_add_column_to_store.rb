class AddColumnToStore < ActiveRecord::Migration
  def change
  	  add_column :stores,:confirmed_at,:datetime
	  add_column :stores,:confirmation_token,:string
	  add_column :stores,:confirmation_sent_at,:datetime
	  add_column :stores, :unconfirmed_email,:string
	  add_column :stores,:confirmable,:string
  end
end
