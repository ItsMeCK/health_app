class Ride < ActiveRecord::Base
	has_many :users, through: :user_rides
end
