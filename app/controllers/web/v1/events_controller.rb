class Web::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /web/v1/events
  # GET /web/v1/events.json
  def index
    @events = Event.all

    render json: @events
  end

  # GET /web/v1/events/1
  # GET /web/v1/events/1.json
  def show
    render json: @event
  end

  # POST /web/v1/events
  # POST /web/v1/events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/events/1
  # PATCH/PUT /web/v1/events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/events/1
  # DELETE /web/v1/events/1.json
  def destroy
    @event.destroy

    head :no_content
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_date, :event_time, :location, :title, :description)
    end
end
