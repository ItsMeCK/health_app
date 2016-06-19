class Mobile::V1::BikesController < ApplicationController
  before_action :set_mobile_v1_bike, only: [:show, :update, :destroy]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @mobile_v1_bikes = Mobile::V1::Bike.all

    render json: @mobile_v1_bikes
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @mobile_v1_bike
  end

  # POST /mobile/v1/bikes
  # POST /mobile/v1/bikes.json
  def create
    @mobile_v1_bike = Mobile::V1::Bike.new(mobile_v1_bike_params)

    if @mobile_v1_bike.save
      render json: @mobile_v1_bike, status: :created, location: @mobile_v1_bike
    else
      render json: @mobile_v1_bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mobile/v1/bikes/1
  # PATCH/PUT /mobile/v1/bikes/1.json
  def update
    @mobile_v1_bike = Mobile::V1::Bike.find(params[:id])

    if @mobile_v1_bike.update(mobile_v1_bike_params)
      head :no_content
    else
      render json: @mobile_v1_bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mobile/v1/bikes/1
  # DELETE /mobile/v1/bikes/1.json
  def destroy
    @mobile_v1_bike.destroy

    head :no_content
  end

  private

    def set_mobile_v1_bike
      @mobile_v1_bike = Mobile::V1::Bike.find(params[:id])
    end

    def mobile_v1_bike_params
      params[:mobile_v1_bike]
    end
end
