class Mobile::V1::BikesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_bike, only: [:show]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @bikes = Bike.all  #.includes(:specifications)
    render json: @bikes, each_serializer: Mobile::V1::BikeSerializer  
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @bike
  end

  def bike_filter
    @bikes = Bike.all
    begin
      @bikes_type =  Bike.joins(:bike_type).where(bike_types: { name: params[:bike_type]}) if params[:bike_type]
    rescue
      "No Bikes"
    end
    begin
      if params[:start_price_value]
        @bikes_price =  @bikes.where(start_price: (params[:start_price_value])..(params[:end_price_value])) if params[:end_price_value]
        #@bikes_price = Bike.joins(:pricings).where("cast(pricings.value as int) >= ? AND cast(pricings.value as int) <= ?", params[:start_price_value], params[:end_price_value]) if params[:end_price_value]
      end
    rescue
      "No Bikes"
    end  
    begin
      @bikes_specification_type = @bikes.where("engine in (?)", params[:engine])
      #@bikes_specification_type = Bike.joins(:specifications).where("specifications.name = ?", "Engine") if params[:engine] 
    rescue
      "No Bikes"
    end  
    begin
      if params[:maximum_cc]
        @bikes_specification = @bikes.where(bike_cc: (params[:minimum_cc])..(params[:maximum_cc]))if params[:minimum_cc] 
        #Bike.joins(:specifications).where("specifications.value >= ? AND specifications.value <= ?", params[:minimum_cc], params[:maximum_cc]) if params[:minimum_cc] 
      end
    rescue
      "No Bikes"
    end  
    bikes = @bikes_type + @bikes_price + @bikes_specification  + @bikes_specification_type
    @bike = bikes.uniq
    render json: @bike
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

end
