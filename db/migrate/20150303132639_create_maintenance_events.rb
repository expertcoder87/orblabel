class CreateMaintenanceEvents < ActiveRecord::Migration
  def change
    create_table :maintenance_events do |t|
      t.integer :type

      t.timestamps null: false
    end
  end
end
