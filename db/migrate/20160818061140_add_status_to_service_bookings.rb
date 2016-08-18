class AddStatusToServiceBookings < ActiveRecord::Migration
  def change
    add_column :service_bookings, :status, :string, default: 'Active'
  end
end
