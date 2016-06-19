class Web::V1::BikeTypesController < ApplicationController
  before_action :set_web_v1_bike_type, only: [:show, :update, :destroy]

  # GET /web/v1/bike_types
  # GET /web/v1/bike_types.json
  def index
    @web_v1_bike_types = Web::V1::BikeType.all

    render json: @web_v1_bike_types
  end

  # GET /web/v1/bike_types/1
  # GET /web/v1/bike_types/1.json
  def show
    render json: @web_v1_bike_type
  end

  # POST /web/v1/bike_types
  # POST /web/v1/bike_types.json
  def create
    @web_v1_bike_type = Web::V1::BikeType.new(web_v1_bike_type_params)

    if @web_v1_bike_type.save
      render json: @web_v1_bike_type, status: :created, location: @web_v1_bike_type
    else
      render json: @web_v1_bike_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bike_types/1
  # PATCH/PUT /web/v1/bike_types/1.json
  def update
    @web_v1_bike_type = Web::V1::BikeType.find(params[:id])

    if @web_v1_bike_type.update(web_v1_bike_type_params)
      head :no_content
    else
      render json: @web_v1_bike_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bike_types/1
  # DELETE /web/v1/bike_types/1.json
  def destroy
    @web_v1_bike_type.destroy

    head :no_content
  end

  private

    def set_web_v1_bike_type
      @web_v1_bike_type = Web::V1::BikeType.find(params[:id])
    end

    def web_v1_bike_type_params
      params[:web_v1_bike_type]
    end
end
