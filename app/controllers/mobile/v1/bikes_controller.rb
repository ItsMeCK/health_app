class Mobile::V1::BikesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_bike, only: [:show]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @bikes = Bike.all.includes(:specifications)
    render json: @bikes
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @bike
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

end
