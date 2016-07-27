class Web::V1::AccessoryCategoriesController < ApplicationController
  before_action :set_accessory_category, only: [:show, :update, :destroy]

  # GET /web/v1/accessory_categories
  # GET /web/v1/accessory_categories.json
  def index
    @accessory_categories = AccessoryCategory.all.order("updated_at DESC").order("created_at DESC")

    render json: @accessory_categories
  end

  # GET /web/v1/accessory_categories/1
  # GET /web/v1/accessory_categories/1.json
  def show
    render json: @accessory_category
  end

  # POST /web/v1/accessory_categories
  # POST /web/v1/accessory_categories.json
  def create
    @accessory_category = AccessoryCategory.new(accessory_category_params)

    if @accessory_category.save
      render json: @accessory_category, status: :created
    else
      render json: @accessory_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/accessory_categories/1
  # PATCH/PUT /web/v1/accessory_categories/1.json
  def update
    @accessory_category = AccessoryCategory.find(params[:id])

    if @accessory_category.update(accessory_category_params)
      head :no_content
    else
      render json: @accessory_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/accessory_categories/1
  # DELETE /web/v1/accessory_categories/1.json
  def destroy
    @accessory_category.destroy

    head :no_content
  end

  private

    def set_accessory_category
      @accessory_category = AccessoryCategory.find(params[:id])
    end

    def accessory_category_params
      params.require(:accessory_category).permit(:title, :description, :image)
    end
end
