class Web::V1::BikeTypesController < ApplicationController
  before_action :set_bike_type, only: [:show, :update, :destroy]

  # GET /web/v1/bike_types
  # GET /web/v1/bike_types.json
  def index
    @bike_types = BikeType.all

    render json: @bike_types
  end

  # GET /web/v1/bike_types/1
  # GET /web/v1/bike_types/1.json
  def show
    render json: @bike_type
  end

  # POST /web/v1/bike_types
  # POST /web/v1/bike_types.json
  def create
    @bike_type = BikeType.new(bike_type_params)

    if @bike_type.save
      render json: @bike_type, status: :created, location: @bike_type
    else
      render json: @bike_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bike_types/1
  # PATCH/PUT /web/v1/bike_types/1.json
  def update
    @bike_type = BikeType.find(params[:id])

    if @bike_type.update(bike_type_params)
      head :no_content
    else
      render json: @bike_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bike_types/1
  # DELETE /web/v1/bike_types/1.json
  def destroy
    @bike_type.destroy

    head :no_content
  end

  private

    def set_bike_type
      @bike_type = BikeType.find(params[:id])
    end

    def bike_type_params
      params[:bike_type]
    end
end
