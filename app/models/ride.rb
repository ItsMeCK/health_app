class Ride < ActiveRecord::Base
	has_many :users, through: :user_rides
	has_many :user_rides
end
