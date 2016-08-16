class ServiceBooking < ActiveRecord::Base
	belongs_to :my_bike

	def my_bike_name
		if MyBike.exists?(self.my_bike_id)
			MyBike.find_by_id(self.my_bike_id).try(:bike) || "null"	
		end
	end
	def user_name
		if MyBike.exists?(self.my_bike_id)
			MyBike.find_by_id(self.my_bike_id).user.profile.try(:full_name) || "null"	
		end
	end
	def user_mobile
		if MyBike.exists?(self.my_bike_id)
			MyBike.find_by_id(self.my_bike_id).user.profile.try(:mobile) || "null"	
		end
	end
	

	def as_json(options={})
		super.as_json(options).merge({:my_bike_name => my_bike_name, :user_name => user_name, :user_mobile => user_mobile})
	end

end
