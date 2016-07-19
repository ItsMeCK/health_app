class Mobile::V1::AccessoryCategoriesController < ApplicationController
  before_action :set_accessory_category, only: [:show]

  # GET /web/v1/accessory_categories
  # GET /web/v1/accessory_categories.json
  def index
    @accessory_categories = AccessoryCategory.all

    render json: @accessory_categories
  end

  # GET /web/v1/accessory_categories/1
  # GET /web/v1/accessory_categories/1.json
  def show
    render json: @accessory_category
  end

  def get_accessories
    @accessories = Accessory.where(accessory_category_id: params[:category_id])
    render json: @accessories
  end

  # POST /web/v1/accessory_categories
 

  private

    def set_accessory_category
      @accessory_category = AccessoryCategory.find(params[:id])
    end

end
