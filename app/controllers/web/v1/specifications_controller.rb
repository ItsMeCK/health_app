class Web::V1::SpecificationsController < ApplicationController
  before_action :set_specification, only: [:show, :update, :destroy]

  # GET /web/v1/specifications
  # GET /web/v1/specifications.json
  def index
    @specifications = Specification.all

    render json: @specifications, each_serializer: Web::V1::SpecificationSerializer
  end

  # GET /web/v1/specifications/1
  # GET /web/v1/specifications/1.json
  def show
    render json: @specification, serializer: Web::V1::SpecificationSerializer
  end

  # POST /web/v1/specifications
  # POST /web/v1/specifications.json
  def create
    @specification = Specification.new(specification_params)

    if @specification.save
      render json: @specification, status: :created, location: @specification, serializer: Web::V1::SpecificationSerializer
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/specifications/1
  # PATCH/PUT /web/v1/specifications/1.json
  def update
    update_params = specification_params(specification_params)
    if @specification.update(update_params)
      render json: @specification, status: :ok, serializer: Web::V1::SpecificationSerializer
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/specifications/1
  # DELETE /web/v1/specifications/1.json
  def destroy
    @specification.destroy

    head :no_content
  end

  private

    def set_specification
      @specification = Specification.find(params[:id])
    end

    def specification_params
      params.require(:specification).permit(:name, :specification_type_id, :bike_id, :value, :active)
    end
end
