class Mobile::V1::BikeTypesController < ApplicationController
  before_action :set_bike_type, only: [:show]

  # GET /mobile/v1/bike_types
  # GET /mobile/v1/bike_types.json
  def index
    @bike_types = BikeType.all

    render json: @bike_types, serializer: BikeTypeSerializer
  end

  # GET /mobile/v1/bike_types/1
  # GET /mobile/v1/bike_types/1.json
  def show
    render json: @bike_type, serializer: BikeTypeSerializer
  end

  private

    def set_bike_type
      @bike_type = BikeType.find(params[:id])
    end

    def bike_type_params
      params[:bike_type]
    end
end
