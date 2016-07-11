class Web::V1::BookingTimeControlsController < ApplicationController
  before_action :set_booking_time_control, only: [:show, :update, :destroy]

  # GET /web/v1/booking_time_controls
  # GET /web/v1/booking_time_controls.json
  def index
    @booking_time_controls = BookingTimeControl.all

    render json: @booking_time_controls, each_serializer: Web::V1::BookingTimeControlSerializer
  end

  # GET /web/v1/booking_time_controls/1
  # GET /web/v1/booking_time_controls/1.json
  def show
    render json: @booking_time_control, serializer: Web::V1::BookingTimeControlSerializer
  end

  # POST /web/v1/booking_time_controls
  # POST /web/v1/booking_time_controls.json
  def create
    @booking_time_control = BookingTimeControl.new(booking_time_control_params)

    if @booking_time_control.save
      render json: @booking_time_control, status: :created, serializer: Web::V1::BookingTimeControlSerializer
    else
      render json: @booking_time_control.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/booking_time_controls/1
  # PATCH/PUT /web/v1/booking_time_controls/1.json
  def update
    @booking_time_control = BookingTimeControl.find(params[:id])

    if @booking_time_control.update(booking_time_control_params)
      render json: @booking_time_control, status: :ok, serializer: Web::V1::BookingTimeControlSerializer
    else
      render json: @booking_time_control.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/booking_time_controls/1
  # DELETE /web/v1/booking_time_controls/1.json
  def destroy
    @booking_time_control.destroy

    head :no_content
  end

  private

    def set_booking_time_control
      @booking_time_control = BookingTimeControl.find(params[:id])
    end

    def booking_time_control_params
      params.require(:booking_time_control).permit(:open_time, :end_time, :category, :days_prior, :weekday, :active)
    end
end