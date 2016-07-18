class Mobile::V1::BikesController < ApplicationController
  #before_filter :authenticate_user!
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

  def bike_filter
    @bikes = Bike.all
    begin
      @bikes_type =  Bike.joins(:bike_type).where(bike_types: { name: params[:bike_type]}) if params[:bike_type]
    rescue
      "No Bikes"
    end
    begin
      if params[:start_price_value] 
        @bikes_price = Bike.joins(:pricings).where("pricings.value >= ? AND pricings.value <= ?", params[:start_price_value], params[:end_price_value]) if params[:end_price_value]
      end
    rescue
      "No Bikes"
    end  
    begin
      @bikes_specification_type = Bike.joins(:specifications).where(specifications: {specification_type: SpecificationType.where(name: params[:specification_type])}) if params[:specification_type] 
    rescue
      "No Bikes"
    end  
    begin
      if params[:end_specification_value]
        @bikes_specification =  Bike.joins(:specifications).where("specifications.value >= ? AND specifications.value <= ?", params[:start_specification_value], params[:end_specification_value]) if params[:start_specification_value] 
      end
    rescue
      "No Bikes"
    end  
    @bikes = @bikes_type.to_a + @bikes_price.to_a + @bikes_specification_type.to_a + @bikes_specification.to_a
     render json: @bikes
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

end
