class Web::V1::TestRidesController < ApplicationController
  before_action :set_test_ride, only: [:show, :update, :destroy]

  # GET /web/v1/test_rides
  # GET /web/v1/test_rides.json
  def index
    @test_rides = TestRide.all

    render json: @test_rides, each_serializer: Web::V1::TestRideSerializer
  end

  # GET /web/v1/test_rides/1
  # GET /web/v1/test_rides/1.json
  def show
    render json: @test_ride, serializer: Web::V1::TestRideSerializer
  end

  # POST /web/v1/test_rides
  # POST /web/v1/test_rides.json
  def create
    @test_ride = TestRide.new(test_ride_params)

    if @test_ride.save
      render json: @test_ride, status: :created, serializer: Web::V1::TestRideSerializer
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/test_rides/1
  # PATCH/PUT /web/v1/test_rides/1.json
  def update
    @test_ride = TestRide.find(params[:id])

    if @test_ride.update(test_ride_params)
      render json: @test_ride, status: :ok, serializer: Web::V1::TestRideSerializer
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/test_rides/1
  # DELETE /web/v1/test_rides/1.json
  def destroy
    @test_ride.destroy

    head :no_content
  end

  private

    def set_test_ride
      @test_ride = TestRide.find(params[:id])
    end

    def test_ride_params
      params.require(:test_ride).permit(:user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location)
    end
end
