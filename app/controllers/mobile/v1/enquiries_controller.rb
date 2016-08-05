class Mobile::V1::EnquiriesController < ApplicationController

  # POST /web/v1/enquiries
  # POST /web/v1/enquiries.json
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      Notification.create(recipient: current_user, actor: current_user, action: I18n.t('Notification.contact_us'), notifiable: current_user)
      render json: @enquiry, status: :created
    else
      render json: @enquiry.errors, status: :unprocessable_entity
    end
  end

  private

    def enquiry_params
      params.require(:enquiry).permit(:name, :phone, :email, :category, :message)
    end
end
