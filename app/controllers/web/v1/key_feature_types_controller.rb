class Web::V1::KeyFeatureTypesController < ApplicationController
  before_action :set_key_feature_type, only: [:show, :update, :destroy]

  # GET /web/v1/key_feature_types
  # GET /web/v1/key_feature_types.json
  def index
    @key_feature_types = KeyFeatureType.all.order("updated_at DESC").order("created_at DESC")

    render json: @key_feature_types
  end

  # GET /web/v1/key_feature_types/1
  # GET /web/v1/key_feature_types/1.json
  def show
    render json: @key_feature_type
  end

  # POST /web/v1/key_feature_types
  # POST /web/v1/key_feature_types.json
  def create
    @key_feature_type = KeyFeatureType.new(key_feature_type_params)

    if @key_feature_type.save
      render json: @key_feature_type, status: :created
    else
      render json: @key_feature_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/key_feature_types/1
  # PATCH/PUT /web/v1/key_feature_types/1.json
  def update
    @key_feature_type = KeyFeatureType.find(params[:id])

    if @key_feature_type.update(key_feature_type_params)
      head :no_content
    else
      render json: @key_feature_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/key_feature_types/1
  # DELETE /web/v1/key_feature_types/1.json
  def destroy
    @key_feature_type.destroy

    head :no_content
  end

  private

    def set_key_feature_type
      @key_feature_type = KeyFeatureType.find(params[:id])
    end

    def key_feature_type_params
      params.require(:key_feature_type).permit(:feature_type_name, :active)
    end
end
