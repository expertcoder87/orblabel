class MakeMaintenanceEventHasOneBikePart < ActiveRecord::Migration
  def change
    change_table :bike_parts do |t|
      t.belongs_to :maintenance_event, index: true
    end
  end
end
