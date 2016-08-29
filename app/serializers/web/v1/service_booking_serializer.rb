class Web::V1::ServiceBookingSerializer < ActiveModel::Serializer
  
  attributes :id, :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :status

  def attributes
  	data = super
  	data[:service_time] = (data[:service_time]).strftime("%H:%M:%S %p")
  	if MyBike.exists?(data[:my_bike_id])
	  	data[:my_bike_name] = (MyBike.find(data[:my_bike_id]).bike if MyBike.exists?(data[:my_bike_id])) || "N/A"
	  	data[:user_email] = (MyBike.find(data[:my_bike_id]).user.try(:email) if MyBike.exists?(data[:my_bike_id])) || "N/A"
	  	data[:user_name] = (MyBike.find(data[:my_bike_id]).user.profile.try(:full_name) if MyBike.exists?(data[:my_bike_id])) || "N/A"
	  	data[:user_mobile] = (MyBike.find(data[:my_bike_id]).user.try(:mobile) if MyBike.exists?(data[:my_bike_id])) || "N/A"
	  	data
	end
  end

end