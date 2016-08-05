class Web::V1::TestRidesController < ApplicationController
  before_action :set_test_ride, only: [:show, :update, :destroy]

  # GET /web/v1/test_rides
  # GET /web/v1/test_rides.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @test_rides = TestRide.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @test_rides, each_serializer: Web::V1::TestRideSerializer
  end

  # GET /web/v1/test_rides/1
  # GET /web/v1/test_rides/1.json
  def show
    render json: @test_ride, serializer: Web::V1::TestRideSerializer
  end

  # POST /web/v1/test_rides
  # POST /web/v1/test_rides.json
  def create
    @test_ride = TestRide.new(test_ride_params)
    if @test_ride.save
      Notification.create(recipient: @test_ride.user, actor: current_user, action: I18n.t('Notification.test_ride_booking'), notifiable: @test_ride)
      render json: @test_ride, status: :created, serializer: Web::V1::TestRideSerializer
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/test_rides/1
  # PATCH/PUT /web/v1/test_rides/1.json
  def update
    @test_ride = TestRide.find(params[:id])
    if @test_ride.update(test_ride_params)
      notification = Notification.where(notifiable: @test_ride).first
      notification.update_attribute(:action, I18n.t('Notification.test_ride_updated'))
      #Notification.send_notification(@test_ride.user, I18n.t('Notification.test_ride_updated'))
      render json: @test_ride, status: :ok, serializer: Web::V1::TestRideSerializer
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/test_rides/1
  # DELETE /web/v1/test_rides/1.json
  def destroy
    notification = Notification.where(notifiable: @test_ride).first
    notification.destroy
    Notification.send_notification(@test_ride.user, I18n.t('Notification.test_ride_destroyed'))
    @test_ride.destroy
    head :no_content
  end

  def all_bookings
   service_bookings = ServiceBooking.where('extract(year  from service_date) = ?', params[:year]).where('extract(month  from service_date) = ?', params[:month])
   test_ride_bookings = TestRide.where('extract(year  from ride_date) = ?',  params[:year]).where('extract(month  from ride_date) = ?',  params[:month]) 
   insurance_bookings = InsuranceRenewal.where('extract(year  from purchase_date) = ?',  params[:year]).where('extract(month  from purchase_date) = ?',  params[:month]) 
   service = service_bookings.collect { |service_booking| date = service_booking.service_date.strftime("%d/%m/%Y") 
    Hash[date, service_booking] }
    test_ride = test_ride_bookings.collect { |test_ride| date = test_ride.ride_date.strftime("%d/%m/%Y")
      Hash[date, test_ride] }
      insurance_renewal = insurance_bookings.collect { |insurance_booking| date = insurance_booking.purchase_date.strftime("%d/%m/%Y") 
        Hash[date, insurance_booking] }
        all_bookings_array = service + test_ride + insurance_renewal
        bookings = all_bookings_array.flat_map(&:entries).group_by(&:first)
        @all_bookings = bookings.map{|k,v| Hash[date: k, all_bookings: v.map(&:last).collect{ |bookings| 
          if bookings.try(:service_date) 
            { service_bookings: bookings }
          elsif bookings.try(:ride_date)
            { test_ride_bookings: bookings }
          elsif bookings.try(:purchase_date)
            { insurence_renewal_bookings: bookings }
          else
            {contact: bookings }
          end
          }.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[k, v.map(&:last)] }  ]  }
    render json: @all_bookings, :root => "bookings"
  end

  private

  def set_test_ride
    @test_ride = TestRide.find(params[:id])
  end

  def test_ride_params
    params.require(:test_ride).permit(:user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location)
  end

end
