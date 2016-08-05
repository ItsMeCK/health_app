class ServiceBooking < ActiveRecord::Base
	belongs_to :my_bike

	def my_bike_name
		if MyBike.exists?(self.my_bike_id)
			MyBike.find(self.my_bike_id).bike
		else
			"N/A"
		end 
	end
	def user_mail
		if MyBike.exists?(self.my_bike_id)
			MyBike.find(self.my_bike_id).user.email
		else
			"N/A"
		end 
	end
	

	def as_json(options={})
		super.as_json(options).merge({:my_bike_name => my_bike_name, :user_email => user_mail})
	end

end
