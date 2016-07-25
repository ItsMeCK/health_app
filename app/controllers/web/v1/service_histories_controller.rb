class Web::V1::ServiceHistoriesController < ApplicationController
  before_action :set_service_history, only: [:show, :update, :destroy]

  # GET /web/v1/service_histories
  # GET /web/v1/service_histories.json
  def index
    @service_histories = ServiceHistory.all

    render json: @service_histories
  end

  # GET /web/v1/service_histories/1
  # GET /web/v1/service_histories/1.json
  def show
    render json: @service_history
  end

  # POST /web/v1/service_histories
  # POST /web/v1/service_histories.json
  def create
    @service_history = ServiceHistory.new(service_history_params)

    if @service_history.save
      render json: @service_history, status: :created
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_histories/1
  # PATCH/PUT /web/v1/service_histories/1.json
  def update
    @service_history = ServiceHistory.find(params[:id])

    if @service_history.update(service_history_params)
      head :no_content
    else
      render json: @service_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_histories/1
  # DELETE /web/v1/service_histories/1.json
  def destroy
    @service_history.destroy

    head :no_content
  end

  private

    def set_service_history
      @service_history = ServiceHistory.find(params[:id])
    end

    def service_history_params
      params.require(:service_history).permit(:service_date, :service_type, :kms, :total_cost, :my_bike_id, :bill_image)
    end
end
