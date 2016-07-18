class Web::V1::AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:show, :update, :destroy]

  # GET /web/v1/accessories
  # GET /web/v1/accessories.json
  def index
    @accessories = Accessory.all

    render json: @accessories
  end

  # GET /web/v1/accessories/1
  # GET /web/v1/accessories/1.json
  def show
    render json: @accessory
  end

  # POST /web/v1/accessories
  # POST /web/v1/accessories.json
  def create
    @accessory = Accessory.new(accessory_params)

    if @accessory.save
      render json: @accessory, status: :created
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/accessories/1
  # PATCH/PUT /web/v1/accessories/1.json
  def update
    @accessory = Accessory.find(params[:id])

    if @accessory.update(accessory_params)
      head :no_content
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/accessories/1
  # DELETE /web/v1/accessories/1.json
  def destroy
    @accessory.destroy

    head :no_content
  end

  private

    def set_accessory
      @accessory = Accessory.find(params[:id])
    end

    def accessory_params
      params.require(:accessory).permit(:title, :description, :tag, :image)
    end
end