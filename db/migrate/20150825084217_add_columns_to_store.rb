class AddColumnsToStore < ActiveRecord::Migration
  def change
    add_column :stores, :status, :boolean
    add_column :stores, :checkbox, :string
  end
end
