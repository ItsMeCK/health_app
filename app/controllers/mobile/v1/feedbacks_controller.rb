class Mobile::V1::FeedbacksController < ApplicationController

  # POST /web/v1/feedbacks
  # POST /web/v1/feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      Notification.create(recipient: current_user, actor: current_user, action: I18n.t('Notification.contact_us'), notifiable: @feedback)
      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:name, :email, :mobile, :feedback_type, :comment, :rating)
    end
end
