class Web::V1::ServiceNumbersController < ApplicationController
  before_action :set_service_number, only: [:show, :update, :destroy]

  # GET /web/v1/service_numbers
  # GET /web/v1/service_numbers.json
  def index
    @service_numbers = ServiceNumber.all

    render json: @service_numbers
  end

  # GET /web/v1/service_numbers/1
  # GET /web/v1/service_numbers/1.json
  def show
    render json: @service_number
  end

  # POST /web/v1/service_numbers
  # POST /web/v1/service_numbers.json
  def create
    @service_number = ServiceNumber.new(service_number_params)

    if @service_number.save
      render json: @service_number, status: :created
    else
      render json: @service_number.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_numbers/1
  # PATCH/PUT /web/v1/service_numbers/1.json
  def update
    @service_number = ServiceNumber.find(params[:id])

    if @service_number.update(service_number_params)
      head :no_content
    else
      render json: @service_number.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_numbers/1
  # DELETE /web/v1/service_numbers/1.json
  def destroy
    @service_number.destroy

    head :no_content
  end

  private

    def set_service_number
      @service_number = ServiceNumber.find(params[:id])
    end

    def service_number_params
      params.require(:service_number).permit(:contact_name, :contact_number)
    end
end
