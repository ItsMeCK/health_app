class Web::V1::BannersController < ApplicationController
  before_action :set_banner, only: [:show, :update, :destroy]

  # GET /web/v1/banners
  # GET /web/v1/banners.json
  def index
    @banners = Banner.all.order("updated_at DESC").order("created_at DESC")

    render json: @banners
  end

  # GET /web/v1/banners/1
  # GET /web/v1/banners/1.json
  def show
    render json: @banner
  end

  # POST /web/v1/banners
  # POST /web/v1/banners.json
  def create
    @banner = Banner.new(banner_params)

    if @banner.save
      render json: @banner, status: :created
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/banners/1
  # PATCH/PUT /web/v1/banners/1.json
  def update
    @banner = Banner.find(params[:id])

    if @banner.update(banner_params)
      head :no_content
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
  end

  def update_image
    @banner = Banner.find(params[:banner][:id])
    @banner.remove_image! if @banner.image
    if @banner.update(banner_params)
      @banner.image = params[:banner][:image]
      @banner.save
      render json: @banner
      #head :no_content
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/banners/1
  # DELETE /web/v1/banners/1.json
  def destroy
    @banner.destroy

    head :no_content
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  end

  def banner_params
    params.require(:banner).permit(:image, :active)
  end
end
