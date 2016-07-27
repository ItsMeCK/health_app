class Web::V1::BikesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_bike, only: [:show, :update, :destroy]

  # GET /web/v1/bikes
  # GET /web/v1/bikes.json
  def index
    @bikes = Bike.all.order("updated_at DESC").order("created_at DESC")
    render json: @bikes.includes(:specifications)  #each_serializer: Web::V1::BikeSerializer
  end

  # GET /web/v1/bikes/1
  # GET /web/v1/bikes/1.json
  def show
    render json: @bike  #serializer: Web::V1::BikeSerializer
  end

  # POST /web/v1/bikes
  # POST /web/v1/bikes.json
  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      render json: @bike, status: :created, serializer: Web::V1::BikeSerializer
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bikes/1
  # PATCH/PUT /web/v1/bikes/1.json
  def update
    @bike = Bike.find(params[:id])

    if @bike.update(bike_params)
      render json: @bike, status: :ok, serializer: Web::V1::BikeSerializer
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
      params.require(:bike).permit(:id, :name, :description, :bike_type_id, :available, :tagline)
    end
end
