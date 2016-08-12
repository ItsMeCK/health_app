class NotificationTemplate < ActiveRecord::Base
	has_many :notifications

	def fill_up_service_booking_template(user, booking)
		a = 5
		self.template % { ServiceBooking_Day:booking.service_date, ServiceBooking_Weekday:a, ServiceBooking_Year:a, ServiceBooking_Month:a, ServiceBooking_Customer_Name:booking.my_bike.user.profile.full_name, vehicle:booking.my_bike.bike, ServiceBooking_Car_RegistrationNumber:booking.my_bike.registration_number, ServiceBooking_Date:booking.service_date, ServiceBooking_Time:booking.service_time, ServiceBooking_ServiceCenter_Name:booking.service_station, servicecenter_number:a, ServiceBooking_ServiceCenter_Number:a  }
	end	
end
