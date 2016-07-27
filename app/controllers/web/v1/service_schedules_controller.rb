class Web::V1::ServiceSchedulesController < ApplicationController
  before_action :set_service_schedule, only: [:show, :update, :destroy]

  # GET /web/v1/service_schedules
  # GET /web/v1/service_schedules.json
  def index
    @service_schedules = ServiceSchedule.all.order("updated_at DESC").order("created_at DESC")

    render json: @service_schedules
  end

  # GET /web/v1/service_schedules/1
  # GET /web/v1/service_schedules/1.json
  def show
    render json: @service_schedule
  end

  # POST /web/v1/service_schedules
  # POST /web/v1/service_schedules.json
  def create
    @service_schedule = ServiceSchedule.new(service_schedule_params)

    if @service_schedule.save
      render json: @service_schedule, status: :created
    else
      render json: @service_schedule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/service_schedules/1
  # PATCH/PUT /web/v1/service_schedules/1.json
  def update
    @service_schedule = ServiceSchedule.find(params[:id])

    if @service_schedule.update(service_schedule_params)
      head :no_content
    else
      render json: @service_schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/service_schedules/1
  # DELETE /web/v1/service_schedules/1.json
  def destroy
    @service_schedule.destroy

    head :no_content
  end

  private

    def set_service_schedule
      @service_schedule = ServiceSchedule.find(params[:id])
    end

    def service_schedule_params
      params.require(:service_schedule).permit(:service_number, :bike_id, :months, :total_kms, :service_type, :range, :active)
    end
end
