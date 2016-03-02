class AddImageToBikes < ActiveRecord::Migration
  def change
  	add_attachment :bikes, :bike_image
  end
end
