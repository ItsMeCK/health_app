class Web::V1::BikesController < ApplicationController
  before_action :set_web_v1_bike, only: [:show, :update, :destroy]

  # GET /web/v1/bikes
  # GET /web/v1/bikes.json
  def index
    @web_v1_bikes = Web::V1::Bike.all

    render json: @web_v1_bikes
  end

  # GET /web/v1/bikes/1
  # GET /web/v1/bikes/1.json
  def show
    render json: @web_v1_bike
  end

  # POST /web/v1/bikes
  # POST /web/v1/bikes.json
  def create
    @web_v1_bike = Web::V1::Bike.new(web_v1_bike_params)

    if @web_v1_bike.save
      render json: @web_v1_bike, status: :created, location: @web_v1_bike
    else
      render json: @web_v1_bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bikes/1
  # PATCH/PUT /web/v1/bikes/1.json
  def update
    @web_v1_bike = Web::V1::Bike.find(params[:id])

    if @web_v1_bike.update(web_v1_bike_params)
      head :no_content
    else
      render json: @web_v1_bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bikes/1
  # DELETE /web/v1/bikes/1.json
  def destroy
    @web_v1_bike.destroy

    head :no_content
  end

  private

    def set_web_v1_bike
      @web_v1_bike = Web::V1::Bike.find(params[:id])
    end

    def web_v1_bike_params
      params[:web_v1_bike]
    end
end
