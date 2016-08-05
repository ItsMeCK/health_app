class Web::V1::ServiceBookingSerializer < ActiveModel::Serializer
  
  attributes :id, :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status

  def attributes
  	data = super
  	data[:service_time] = (data[:service_time]).strftime("%H:%M:%S %p")
  	data[:my_bike_name] = MyBike.find(data[:my_bike_id]).bike if MyBike.exists?(data[:my_bike_id])
  	data[:user_email] = MyBike.find(data[:my_bike_id]).user.email if MyBike.exists?(data[:my_bike_id])
  	data
  end

end