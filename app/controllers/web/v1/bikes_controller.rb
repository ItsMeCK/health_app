class Web::V1::BikesController < ApplicationController
  before_action :set_bike, only: [:show, :update, :destroy]

  # GET /web/v1/bikes
  # GET /web/v1/bikes.json
  def index
    @bikes = Bike.all

    render json: @bikes, each_serializer: Web::V1::BikeSerializer
  end

  # GET /web/v1/bikes/1
  # GET /web/v1/bikes/1.json
  def show
    render json: @bike, serializer: Web::V1::BikeSerializer
  end

  # POST /web/v1/bikes
  # POST /web/v1/bikes.json
  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      render json: @bike, status: :created, location: @bike, serializer: Web::V1::BikeSerializer
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bikes/1
  # PATCH/PUT /web/v1/bikes/1.json
  def update
    @bike = Bike.find(params[:id])

    if @bike.update(bike_params)
      render json: @bike, status: :ok, location: @bike, serializer: Web::V1::BikeSerializer
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bikes/1
  # DELETE /web/v1/bikes/1.json
  def destroy
    @bike.destroy

    head :no_content
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params[:bike]
    end
end
