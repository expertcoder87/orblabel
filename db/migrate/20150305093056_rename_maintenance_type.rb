class RenameMaintenanceType < ActiveRecord::Migration
  def change
    rename_column :maintenance_events, :type, :bike_part_type
  end
end
