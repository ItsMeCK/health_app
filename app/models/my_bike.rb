class MyBike < ActiveRecord::Base
	belongs_to :user
	has_many :service_bookings
end
