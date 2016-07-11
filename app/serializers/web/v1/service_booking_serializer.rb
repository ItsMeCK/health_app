class Web::V1::ServiceBookingSerializer < ActiveModel::Serializer
  
  attributes :id, :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status

  def attributes
  	data = super
  	data[:service_time] = (data[:service_time]).strftime("%H:%M:%S %p")
  	data
  end

end