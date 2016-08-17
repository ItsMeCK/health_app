class Mobile::V1::EnquiriesController < ApplicationController

  # POST /web/v1/enquiries
  # POST /web/v1/enquiries.json
  def create
    @enquiry = Enquiry.new(enquiry_params)

    if @enquiry.save
      template = NotificationTemplate.where(category: I18n.t('Notification.contact_us')).last
      Notification.create(recipient: current_user, actor: current_user, action: 'Offer', notifiable: @enquiry, notification_template: template)
      UserMailer.contact_us(@enquiry)
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
