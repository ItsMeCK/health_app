class Web::V1::DealerTypesController < ApplicationController
  before_action :se_dealer_type, only: [:show]

  # GET /web/v1/dealer_types
  # GET /web/v1/dealer_types.json
  # def index
  #  @dealer_types = DealerType.all

  #   render json:@dealer_types
  # end

  # GET /web/v1/dealer_types/1
  # GET /web/v1/dealer_types/1.json
  def show
    render json:@dealer_type
  end

  # POST /web/v1/dealer_types
  # POST /web/v1/dealer_types.json
 
  private

    def se_dealer_type
     @dealer_type = DealerType.find(params[:id])
    end

   
end
