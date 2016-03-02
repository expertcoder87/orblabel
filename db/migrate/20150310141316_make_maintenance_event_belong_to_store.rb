class MakeMaintenanceEventBelongToStore < ActiveRecord::Migration
  def change
    change_table :maintenance_events do |t|
      t.belongs_to :store, index: true
    end
  end
end
