class MakeStoreHasManyBikes < ActiveRecord::Migration
  def change
    change_table :bikes do |t|
      t.belongs_to :store, index: true
    end
  end
end
