class Mobile::V1::SpecificationsController < ApplicationController
  before_action :set_specification, only: [:show, :update, :destroy]

  # GET /mobile/v1/specifications
  # GET /mobile/v1/specifications.json
  def index
    @specifications = Specification.all

    render json: @specifications
  end

  # GET /mobile/v1/specifications/1
  # GET /mobile/v1/specifications/1.json
  def show
    render json: @specification
  end

  # POST /mobile/v1/specifications
  # POST /mobile/v1/specifications.json
  def create
    @specification = Specification.new(specification_params)

    if @specification.save
      render json: @specification, status: :created, location: @specification
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mobile/v1/specifications/1
  # PATCH/PUT /mobile/v1/specifications/1.json
  def update
    @specification = Specification.find(params[:id])

    if @specification.update(specification_params)
      head :no_content
    else
      render json: @specification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mobile/v1/specifications/1
  # DELETE /mobile/v1/specifications/1.json
  def destroy
    @specification.destroy

    head :no_content
  end

  private

    def set_specification
      @specification = Specification.find(params[:id])
    end

    def specification_params
      params[:specification]
    end
end
