class Mobile::V1::ServiceSchedulesController < ApplicationController
  before_action :set_service_schedule, only: [:show, :update, :destroy]

  # GET /web/v1/service_schedules
  # GET /web/v1/service_schedules.json
  def index
    @service_schedules = ServiceSchedule.all

    render json: @service_schedules
  end

  # GET /web/v1/service_schedules/1
  # GET /web/v1/service_schedules/1.json
  def show
    render json: @service_schedule
  end

  # POST /web/v1/service_schedules
 

  private

    def set_service_schedule
      @service_schedule = ServiceSchedule.find(params[:id])
    end

end
