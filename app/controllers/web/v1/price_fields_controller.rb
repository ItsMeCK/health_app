class Web::V1::PriceFieldsController < ApplicationController
  before_action :set_price_field, only: [:show, :update, :destroy]

  # GET /web/v1/price_fields
  # GET /web/v1/price_fields.json
  def index
    @price_fields = PriceField.all.order("updated_at DESC").order("created_at DESC")

    render json: @price_fields
  end

  # GET /web/v1/price_fields/1
  # GET /web/v1/price_fields/1.json
  def show
    render json: @price_field
  end

  # POST /web/v1/price_fields
  # POST /web/v1/price_fields.json
  def create
    @price_field = PriceField.new(price_field_params)

    if @price_field.save
      render json: @price_field, status: :created
    else
      render json: @price_field.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/price_fields/1
  # PATCH/PUT /web/v1/price_fields/1.json
  def update
    @price_field = PriceField.find(params[:id])

    if @price_field.update(price_field_params)
      head :no_content
    else
      render json: @price_field.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/price_fields/1
  # DELETE /web/v1/price_fields/1.json
  def destroy
    @price_field.destroy

    head :no_content
  end

  private

    def set_price_field
      @price_field = PriceField.find(params[:id])
    end

    def price_field_params
      params.require(:price_field).permit(:name, :display_order, :active)
    end
end
