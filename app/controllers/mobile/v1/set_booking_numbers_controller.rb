class Mobile::V1::SetBookingNumbersController < ApplicationController
  before_action :set_set_booking_number, only: [:show]

  # GET /web/v1/set_booking_numbers
  # GET /web/v1/set_booking_numbers.json
  def index
    @set_booking_numbers = SetBookingNumber.all

    render json: @set_booking_numbers
  end

  # GET /web/v1/set_booking_numbers/1
  # GET /web/v1/set_booking_numbers/1.json
  def show
    render json: @set_booking_number
  end

  def find_by_categopry
    @category =  SetBookingNumber.find_by_category(params[:category])
    render json: @category
  end

  # POST /web/v1/set_booking_numbers
  # POST /web/v1/set_booking_numbers.json
 

  private

    def set_set_booking_number
      @set_booking_number = SetBookingNumber.find(params[:id])
    end
end

