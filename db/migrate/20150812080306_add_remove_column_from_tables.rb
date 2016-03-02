class AddRemoveColumnFromTables < ActiveRecord::Migration
  def change
  	remove_column :bikes,:selling_price,:string
  	remove_column :bikes,:access_code,:string
  	remove_attachment :bikes, :receipt_image
  	add_column :certified_bikes,:access_code,:string
  	add_column :uncertified_bikes,:access_code,:string
  end
end
