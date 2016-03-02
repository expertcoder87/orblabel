class AddCertificateColumnToStore < ActiveRecord::Migration
  def change
  	add_column :stores,:no_of_certificate,:integer
  end
end
