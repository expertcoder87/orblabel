class AddBikeRegistrationConfirm < ActiveRecord::Migration
  def change
  	add_column :bikes, :bike_registration_confirm, :boolean
  end
end
