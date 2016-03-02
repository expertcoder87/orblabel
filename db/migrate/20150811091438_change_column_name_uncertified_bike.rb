class ChangeColumnNameUncertifiedBike < ActiveRecord::Migration
  def change
  	change_column :uncertified_bikes, :cpf, :string
  end
end
