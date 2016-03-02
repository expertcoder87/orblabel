class AddColumnToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :communication_check, :boolean
  end
end
