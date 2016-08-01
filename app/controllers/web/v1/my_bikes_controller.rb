class Web::V1::MyBikesController < ApplicationController
  before_action :set_my_bike, only: [:show, :update, :destroy]

  # GET /web/v1/my_bikes
  # GET /web/v1/my_bikes.json
  def index
    @my_bikes = MyBike.all.order("updated_at DESC").order("created_at DESC")

    render json: @my_bikes
  end

  # GET /web/v1/my_bikes/1
  # GET /web/v1/my_bikes/1.json
  def show
    render json: @my_bike
  end

  # POST /web/v1/my_bikes
  # POST /web/v1/my_bikes.json
  def create
    @my_bike = MyBike.new(my_bike_params)

    if @my_bike.save
      render json: @my_bike, status: :created
    else
      render json: @my_bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/my_bikes/1
  # PATCH/PUT /web/v1/my_bikes/1.json
  def update
    @my_bike = MyBike.find(params[:id])
    
    if @my_bike.update(my_bike_params)
      render json: @my_bike
      #head :no_content
    else
      render json: @my_bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/my_bikes/1
  # DELETE /web/v1/my_bikes/1.json
  def destroy
    @my_bike.destroy

    head :no_content
  end

  private

    def set_my_bike
      @my_bike = MyBike.find(params[:id])
    end

    def my_bike_params
      params.require(:my_bike).permit(:bike, :purchase_date, :my_bike_image_url, :default_bike_image_id, :registration_number, :insurance_provider, :insurance_number, :insurance_expiry_date, :engine_number, :last_service_date, :user_id, :bike_image, :kms)
    end
end
