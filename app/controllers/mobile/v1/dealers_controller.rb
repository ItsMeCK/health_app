class Mobile::V1::DealersController < ApplicationController
  before_action :set_dealer, only: [:show]
  skip_before_filter :authenticate_user!

  # GET /web/v1/dealers
  # GET /web/v1/dealers.json
  def index
    @dealers = Dealer.all.order("service_display_order")

    render json: @dealers
  end

  # GET /web/v1/dealers/1
  # GET /web/v1/dealers/1.json
  def show
    render json: @dealer
  end

  def dealer_contact_numbers
    @dealer = Dealer.all
    @dealer_contact_number = []
    @dealer.each do |dealer|
      dealer_contact = dealer.dealer_contact_numbers
      @dealer_contact_number << {dealer: dealer, dealer_contact_number: dealer_contact}
    end
    @dealer_contact_number
    render json: @dealer_contact_number
  end

  # POST /web/v1/dealers
 

  private

    def set_dealer
      @dealer = Dealer.find(params[:id])
    end

end
