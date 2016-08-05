class AddMigrationDateToUserRideAndEvents < ActiveRecord::Migration
  def change
  	add_column :user_rides, :user_ride_date, :date
  	add_column :user_events, :user_event_date, :date
  end
end
