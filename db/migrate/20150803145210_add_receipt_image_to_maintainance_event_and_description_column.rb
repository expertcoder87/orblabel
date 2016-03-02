class AddReceiptImageToMaintainanceEventAndDescriptionColumn < ActiveRecord::Migration
  def change
  	  	add_attachment :maintenance_events, :maintenance_receipt_image
  	  	add_column :maintenance_events,:description,:text
  end
end
