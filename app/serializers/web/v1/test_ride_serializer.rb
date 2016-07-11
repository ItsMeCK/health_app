class Web::V1::TestRideSerializer < ActiveModel::Serializer
  
  attributes :id, :user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location

  def attributes
  	data = super
  	data[:ride_time] = (data[:ride_time]).strftime("%H:%M:%S %p")
  	data
  end

end