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
      user = User.find @service_booking.user_id
      template = NotificationTemplate.where(category: I18n.t('Notification.service_booking')).last
      Notification.create(recipient: current_user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)
      render json: @service_booking, status: :created, serializer: Mobile::V1::ServiceBookingSerializer
      #mail to admin
      UserMailer.service_booking(@service_booking, "Service confirmation mail-dealer").deliver
      #mail to confirm user
      UserMailer.service_request_confirm(@service_booking, "Service confirmation mail-user").deliver
    else
        render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_bookings/1
  # PATCH/PUT /web/v1/service_bookings/1.json
  def update
    @service_booking = ServiceBooking.find(params[:id])

    if @service_booking.update(service_booking_params)
      template = NotificationTemplate.where(category: I18n.t('Notification.service_booking_updated')).last
      Notification.create(recipient: current_user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)      
      UserMailer.service_booking(@service_booking, "Service confirmation update mail-dealer").deliver
      UserMailer.service_request_confirm(@service_booking, "Service confirmation update mail-user").deliver
      render json: @service_booking, status: :ok, serializer: Mobile::V1::ServiceBookingSerializer
    else
      render json: @service_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_bookings/1
  # DELETE /web/v1/service_bookings/1.json
  def destroy
    template = NotificationTemplate.where(category: I18n.t('Notification.service_booking_destroyed')).last
    Notification.create(recipient: current_user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)      
    UserMailer.service_booking(@service_booking, "Service booking delete mail-dealer").deliver
    UserMailer.service_request_confirm(@service_booking, "Service booking delete mail-user").deliver
    @service_booking.update_attribute(:status, 'Canceled')
    head :no_content
  end

  def my_bookings
    @old_bookings = (ServiceBooking.where('(user_id = ? AND service_date < ?) OR status = ?', params[:user_id], Date.today, 'Canceled').order(:updated_at).reverse_order + TestRide.where('(user_id = ? AND ride_date < ?) OR status = ?', params[:user_id], Date.today, 'Canceled').order(:updated_at).reverse_order)
    @new_bookings = (ServiceBooking.where('user_id = ? AND service_date > ? AND status = ?', params[:user_id], Date.today, 'Active').order(:updated_at).reverse_order + TestRide.where('user_id = ? AND ride_date > ? AND status = ?', params[:user_id], Date.today, 'Active').order(:updated_at).reverse_order)
    @bookings_all = Hash.new
    @bookings_all = {:old_bookings => @old_bookings, :new_bookings =>  @new_bookings}
    render json: @bookings_all
  end

  def delete_service_bookings
    @service_bookings = params[:service_booking_ids]
    @service_bookings.each do |service_booking|
      ServiceBooking.find(service_booking).delete
    end
  end

  private

  def set_service_booking
    @service_booking = ServiceBooking.find(params[:id])
  end

  def service_booking_params
    params.require(:service_booking).permit(:service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status)
  end
end
