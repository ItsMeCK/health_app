class Web::V1::DealersController < ApplicationController
  before_action :set_dealer, only: [:show, :update, :destroy]

  # GET /web/v1/dealers
  # GET /web/v1/dealers.json
  def index
    @dealers = Dealer.all.order("updated_at DESC").order("created_at DESC")

    render json: @dealers
  end

  # GET /web/v1/dealers/1
  # GET /web/v1/dealers/1.json
  def show
    render json: @dealer
  end

  # POST /web/v1/dealers
  # POST /web/v1/dealers.json
  def create
    @dealer = Dealer.new(dealer_params)
    @dealer.dealer_type_id = params[:dealer][:dealer_type_id]
    
    if @dealer.save
      render json: @dealer, status: :created
    else
      render json: @dealer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/dealers/1
  # PATCH/PUT /web/v1/dealers/1.json
  def update
    @dealer = Dealer.find(params[:id])
    if params[:dealer][:dealer_type_id]
      @dealer.dealer_type_id.replace(params[:dealer][:dealer_type_id])
    end

    if @dealer.update(dealer_params)
      head :no_content
    else
      render json: @dealer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/dealers/1
  # DELETE /web/v1/dealers/1.json
  def destroy
    @dealer.destroy

    head :no_content
  end

  private

  def set_dealer
    @dealer = Dealer.find(params[:id])
  end

  def dealer_params
    params.require(:dealer).permit(:dealer_name, :address, :dealer_type_id, :working_hours, :email, :latitude, :longitude, :active, :image, :service_display_order, :sales_display_order)
  end
end
