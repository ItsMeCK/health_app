class Mobile::V1::BikesController < ApplicationController
  before_action :set_bike, only: [:show]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @bikes = Bike.all
    render json: @bikes, serializer: BikeSerializer
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @bike, serializer: BikeSerializer
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params[:bike]
    end
end
