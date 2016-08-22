class Web::V1::ServiceBookingsController < ApplicationController
  before_action :set_service_booking, only: [:show, :update, :destroy]

  # GET /web/v1/service_bookings
  # GET /web/v1/service_bookings.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @service_bookings = ServiceBooking.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @service_bookings, each_serializer: Web::V1::ServiceBookingSerializer
  end

  # GET /web/v1/service_bookings/1
  # GET /web/v1/service_bookings/1.json
  def show
    render json: @service_booking, serializer: Web::V1::ServiceBookingSerializer
  end

  # POST /web/v1/service_bookings
  # POST /web/v1/service_bookings.json
  def create
    @service_booking = ServiceBooking.new(service_booking_params)
    if @service_booking.save 
      user = User.find @service_booking.user_id
      template = NotificationTemplate.where(category: I18n.t('Notification.service_booking')).last
      Notification.create(recipient: user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)
     #mail to admin
      UserMailer.service_booking(@service_booking, "Service confirmation mail-dealer")
        #mail to confirm user
      UserMailer.service_request_confirm(@service_booking, "Service confirmation mail-user")    
      render json: @service_booking, status: :created, serializer: Web::V1::ServiceBookingSerializer
    else
      render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_bookings/1
  # PATCH/PUT /web/v1/service_bookings/1.json
  def update
    if @service_booking.update(service_booking_params)
      user = User.find @service_booking.user_id
      template = NotificationTemplate.where(category: I18n.t('Notification.service_booking_updated')).last
      Notification.create(recipient: user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)      
      UserMailer.service_booking(@service_booking, "Service confirmation update mail-dealer").deliver
      UserMailer.service_request_confirm(@service_booking, "Service confirmation update mail-user").deliver
      render json: @service_booking, status: :ok, serializer: Web::V1::ServiceBookingSerializer
    else
      render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_bookings/1
  # DELETE /web/v1/service_bookings/1.json
  def destroy
    user = User.find @service_booking.user_id
    template = NotificationTemplate.where(category: I18n.t('Notification.service_booking_destroyed')).last
    Notification.create(recipient: user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)      
    UserMailer.service_booking(@service_booking, "Service booking delete mail-dealer").deliver
    UserMailer.service_request_confirm(@service_booking, "Service booking delete mail-user").deliver
    @service_booking.destroy
    head :no_content
  end

  private

    def set_service_booking
      @service_booking = ServiceBooking.find(params[:id])
    end

    def service_booking_params
      params.require(:service_booking).permit(:service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status)
    end
end
