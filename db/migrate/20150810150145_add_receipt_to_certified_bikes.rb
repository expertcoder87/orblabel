class AddReceiptToCertifiedBikes < ActiveRecord::Migration
  def change
  	remove_attachment :certified_bikes, :receipt
  	add_attachment :certified_bikes,:receipt
  	add_column :certified_bikes,:bike_id,:integer
  end
end
