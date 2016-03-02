class RenameTypeOfBikePartToBikePartType < ActiveRecord::Migration
  def change
    rename_column :bike_parts, :type, :bike_part_type
  end
end
