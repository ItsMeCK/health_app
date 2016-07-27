class Web::V1::PricingsController < ApplicationController
  before_action :set_pricing, only: [:show, :update, :destroy]

  # GET /web/v1/pricings
  # GET /web/v1/pricings.json
  def index
    @pricings = Pricing.all.order("updated_at DESC").order("created_at DESC")

    render json: @pricings
  end

  # GET /web/v1/pricings/1
  # GET /web/v1/pricings/1.json
  def show
    render json: @pricing
  end

  # POST /web/v1/pricings
  # POST /web/v1/pricings.json
  def create
    @pricing = Pricing.new(pricing_params)

    if @pricing.save
      render json: @pricing, status: :created
    else
      render json: @pricing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/pricings/1
  # PATCH/PUT /web/v1/pricings/1.json
  def update
    @pricing = Pricing.find(params[:id])

    if @pricing.update(pricing_params)
      head :no_content
    else
      render json: @pricing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/pricings/1
  # DELETE /web/v1/pricings/1.json
  def destroy
    @pricing.destroy

    head :no_content
  end

  private

    def set_pricing
      @pricing = Pricing.find(params[:id])
    end

    def pricing_params
      params.require(:pricing).permit(:value, :price_field_id, :bike_id, :active)
    end
end
