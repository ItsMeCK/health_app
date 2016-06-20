class Mobile::V1::BikesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_bike, only: [:show]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @bikes = Bike.all
    render json: @bikes.includes(:specification), each_serializer: Mobile::V1::BikeSerializer
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @bike, serializer: Mobile::V1::BikeSerializer
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params[:bike]
    end
end
