class Mobile::V1::BikeTypesController < ApplicationController
  before_action :set_mobile_v1_bike_type, only: [:show, :update, :destroy]

  # GET /mobile/v1/bike_types
  # GET /mobile/v1/bike_types.json
  def index
    @mobile_v1_bike_types = Mobile::V1::BikeType.all

    render json: @mobile_v1_bike_types
  end

  # GET /mobile/v1/bike_types/1
  # GET /mobile/v1/bike_types/1.json
  def show
    render json: @mobile_v1_bike_type
  end

  # POST /mobile/v1/bike_types
  # POST /mobile/v1/bike_types.json
  def create
    @mobile_v1_bike_type = Mobile::V1::BikeType.new(mobile_v1_bike_type_params)

    if @mobile_v1_bike_type.save
      render json: @mobile_v1_bike_type, status: :created, location: @mobile_v1_bike_type
    else
      render json: @mobile_v1_bike_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mobile/v1/bike_types/1
  # PATCH/PUT /mobile/v1/bike_types/1.json
  def update
    @mobile_v1_bike_type = Mobile::V1::BikeType.find(params[:id])

    if @mobile_v1_bike_type.update(mobile_v1_bike_type_params)
      head :no_content
    else
      render json: @mobile_v1_bike_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mobile/v1/bike_types/1
  # DELETE /mobile/v1/bike_types/1.json
  def destroy
    @mobile_v1_bike_type.destroy

    head :no_content
  end

  private

    def set_mobile_v1_bike_type
      @mobile_v1_bike_type = Mobile::V1::BikeType.find(params[:id])
    end

    def mobile_v1_bike_type_params
      params[:mobile_v1_bike_type]
    end
end
