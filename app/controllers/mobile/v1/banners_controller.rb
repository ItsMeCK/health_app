class Mobile::V1::BannersController < ApplicationController
  before_action :set_banner, only: [:show, :update, :destroy]

  # GET /web/v1/banners
  # GET /web/v1/banners.json
  def index
    @banners = Banner.all

    render json: @banners
  end

  # GET /web/v1/banners/1
  # GET /web/v1/banners/1.json
  def show
    render json: @banner
  end



  private

    def set_banner
      @banner = Banner.find(params[:id])
    end
    
end
