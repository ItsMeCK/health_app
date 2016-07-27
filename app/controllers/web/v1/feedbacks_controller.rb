class Web::V1::FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show]

  # GET /web/v1/feedbacks
  # GET /web/v1/feedbacks.json
  def index
    @feedbacks = Feedback.all.order("updated_at DESC").order("created_at DESC")

    render json: @feedbacks
  end

  # GET /web/v1/feedbacks/1
  # GET /web/v1/feedbacks/1.json
  def show
    render json: @feedback
  end

  # POST /web/v1/feedbacks
  # POST /web/v1/feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:name, :mobile, :feedback_type, :email, :comment, :rating)
    end
end
