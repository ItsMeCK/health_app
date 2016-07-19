class Web::V1::DealersController < ApplicationController
  before_action :set_dealer, only: [:show]

  # GET /web/v1/dealers
  # GET /web/v1/dealers.json
  # def index
  #   @dealers = Dealer.all

  #   render json: @dealers
  # end

  # GET /web/v1/dealers/1
  # GET /web/v1/dealers/1.json
  def show
    render json: @dealer
  end

  # POST /web/v1/dealers
 

  private

    def set_dealer
      @dealer = Dealer.find(params[:id])
    end

end
