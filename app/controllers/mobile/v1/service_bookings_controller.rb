class Mobile::V1::ServiceBookingsController < ApplicationController
  before_action :set_service_booking, only: [:show, :update, :destroy]

  # GET /web/v1/service_bookings
  # GET /web/v1/service_bookings.json
  def index
    @service_bookings = ServiceBooking.all

    render json: @service_bookings
  end

  # GET /web/v1/service_bookings/1
  # GET /web/v1/service_bookings/1.json
  def show
    render json: @service_booking
  end

  # POST /web/v1/service_bookings
  # POST /web/v1/service_bookings.json
  def create
    @service_booking = ServiceBooking.new(service_booking_params)

    if @service_booking.save
      render json: @service_booking, status: :created
    else
      render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_bookings/1
  # PATCH/PUT /web/v1/service_bookings/1.json
  def update
    @service_booking = ServiceBooking.find(params[:id])

    if @service_booking.update(service_booking_params)
      head :no_content
    else
      render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_bookings/1
  # DELETE /web/v1/service_bookings/1.json
  def destroy
    @service_booking.destroy

    head :no_content
  end

  def my_bookings
    @old_bookings = ServiceBooking.where('user_id = ? AND service_date < ?', params[:user_id], Date.today).order(:updated_at).reverse_order + TestRide.where('user_id = ? AND ride_date < ?', params[:user_id], Date.today).order(:updated_at).reverse_order
    @new_bookings = ServiceBooking.where('user_id = ? AND service_date > ?', params[:user_id], Date.today).order(:updated_at).reverse_order + TestRide.where('user_id = ? AND ride_date > ?', params[:user_id], Date.today).order(:updated_at).reverse_order
    @bookings_all = Hash.new
    @bookings_all = {:old_bookings => @old_bookings, :new_bookings =>  @new_bookings}
    render json: @bookings_all
  end

  private

    def set_service_booking
      @service_booking = ServiceBooking.find(params[:id])
    end

    def service_booking_params
      params.require(:service_booking).permit(:user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status)
    end
end
