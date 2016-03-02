class AddRoberyAlertColumnToBike < ActiveRecord::Migration
  def change
  	add_column :bikes,:robery_alert,:boolean
  end
end
