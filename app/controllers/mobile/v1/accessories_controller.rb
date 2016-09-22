class Web::V1::AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:show, :update, :destroy]

  # GET /web/v1/accessories
  # GET /web/v1/accessories.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    accs = []
    Tag.all.each do |tag|
      a = {}
      a["tag_name"] = tag.name 
      a["accessories"] = tag.accessories || []
      a["image"] = tag.image || ""
      accs << a 
    end  
    render json: accs
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
      AccessoryTag.create(accessory_id: @accessory.id, tag_id: params[:accessory][:tag_id])
      audit(@accessory, current_user)
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
      audit(@accessory, current_user)
      head :no_content
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  def update_accessory_image
    @accessory = Accessory.find(params[:id])
    @accessory.remove_image! if @accessory.image
    if @accessory.update(accessory_params)
      @accessory.image = params[:accessory][:image]
      @accessory.save
      render json: @accessory
      #head :no_content
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/accessories/1
  # DELETE /web/v1/accessories/1.json
  def destroy
    audit(@accessory, current_user)
    @accessory.destroy
    

    head :no_content
  end

  def get_accessories_enquiries
    @accessory_enquiries = AccessoryEnquiry.all
    render json: @accessory_enquiries
  end

  def delete_accessories
    @accessories = params[:accessories_ids]
   @accessories.each do |accessories|
    Accessory.find(accessories).delete
  end
end

private

def set_accessory
  @accessory = Accessory.find(params[:id])
end

def accessory_params
  params.require(:accessory).permit(:title, :description, :tag, :image, :accessory_category_id, :part_number, :size, :price,:brand)
end
end
