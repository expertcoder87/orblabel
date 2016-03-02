class MakeStoreHasOneAddress < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.belongs_to :store, index: true
    end
  end
end
