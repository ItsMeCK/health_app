class Web::V1::ContactNumbersController < ApplicationController
  before_action :set_contact_number, only: [:show, :update, :destroy]

  # GET /web/v1/contact_numbers
  # GET /web/v1/contact_numbers.json
  def index
    @contact_numbers = ContactNumber.all

    render json: @contact_numbers
  end

  # GET /web/v1/contact_numbers/1
  # GET /web/v1/contact_numbers/1.json
  def show
    render json: @contact_number
  end

  # POST /web/v1/contact_numbers
  # POST /web/v1/contact_numbers.json
  def create
    @contact_number = ContactNumber.new(contact_number_params)

    if @contact_number.save
      render json: @contact_number, status: :created
    else
      render json: @contact_number.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/contact_numbers/1
  # PATCH/PUT /web/v1/contact_numbers/1.json
  def update
    @contact_number = ContactNumber.find(params[:id])

    if @contact_number.update(contact_number_params)
      head :no_content
    else
      render json: @contact_number.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/contact_numbers/1
  # DELETE /web/v1/contact_numbers/1.json
  def destroy
    @contact_number.destroy

    head :no_content
  end

  private

    def set_contact_number
      @contact_number = ContactNumber.find(params[:id])
    end

    def contact_number_params
      params.require(:contact_number).permit(:category, :number, :label, :contact_type_id)
    end
end
