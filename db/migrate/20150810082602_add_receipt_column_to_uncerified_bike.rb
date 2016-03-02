class AddReceiptColumnToUncerifiedBike < ActiveRecord::Migration
  def change
  	add_attachment :uncertified_bikes, :receipt
  end
end
