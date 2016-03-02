class AddReceiptImageToBikePart < ActiveRecord::Migration
  def change
  	add_attachment :bike_parts, :bike_parts_receipt_image
  end
end
