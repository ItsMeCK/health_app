class Web::V1::DefaultBikeImagesController < ApplicationController
  before_action :set_default_bike_image, only: [:show, :update, :destroy]

  # GET /web/v1/default_bike_images
  # GET /web/v1/default_bike_images.json
  def index
    @default_bike_images = DefaultBikeImage.all

    render json: @default_bike_images
  end

  # GET /web/v1/default_bike_images/1
  # GET /web/v1/default_bike_images/1.json
  def show
    render json: @default_bike_image
  end

  # POST /web/v1/default_bike_images
  # POST /web/v1/default_bike_images.json
  def create
    @default_bike_image = DefaultBikeImage.new(default_bike_image_params)

    if @default_bike_image.save
      render json: @default_bike_image, status: :created
    else
      render json: @default_bike_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/default_bike_images/1
  # PATCH/PUT /web/v1/default_bike_images/1.json
  def update
    @default_bike_image = DefaultBikeImage.find(params[:id])

    if @default_bike_image.update(default_bike_image_params)
      head :no_content
    else
      render json: @default_bike_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/default_bike_images/1
  # DELETE /web/v1/default_bike_images/1.json
  def destroy
    @default_bike_image.destroy

    head :no_content
  end

  private

    def set_default_bike_image
      @default_bike_image = DefaultBikeImage.find(params[:id])
    end

    def default_bike_image_params
      params.require(:default_bike_image).permit(:image_url, :bike_id)
    end
end
