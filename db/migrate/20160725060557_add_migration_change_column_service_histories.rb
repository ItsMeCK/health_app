class AddMigrationChangeColumnServiceHistories < ActiveRecord::Migration
  def change
  	remove_column :service_histories, :bike_id
  	add_column :service_histories, :my_bike_id, :integer 
  end
end
