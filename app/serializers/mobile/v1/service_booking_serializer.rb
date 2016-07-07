class Mobile::V1::ServiceBookingSerializer < ActiveModel::Serializer
  attributes :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status
 
  def attributes
  	data = super
  	data[:my_bike] = MyBike.find_by_id(data[:my_bike_id]).bike
  	data[:user] = User.find_by_id(data[:user_id]).profile.full_name
  	# data[:service_time] = (data[:service_time]).strftime("\%I:%M:%S %p")
  	# data[:service_date] = (data[:service_date]).strftime("%B %d, %Y")
  	data
	end
  

end