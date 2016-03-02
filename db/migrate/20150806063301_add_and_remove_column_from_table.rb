class AddAndRemoveColumnFromTable < ActiveRecord::Migration
  def change
  	remove_column :maintenance_events,:bike_id,:integer
  	remove_attachment :bike_parts, :bike_parts_receipt_image
  	add_column :maintenance_events,:bike_id,:integer
  end
end
