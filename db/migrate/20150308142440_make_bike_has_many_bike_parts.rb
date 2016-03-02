class MakeBikeHasManyBikeParts < ActiveRecord::Migration
  def change
    change_table :bike_parts do |t|
      t.belongs_to :bike, index: true
    end
  end
end
