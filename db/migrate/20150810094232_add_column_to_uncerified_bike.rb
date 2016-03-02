class AddColumnToUncerifiedBike < ActiveRecord::Migration
  def change
  	add_column :uncertified_bikes,:bike_id,:integer
  end
end
