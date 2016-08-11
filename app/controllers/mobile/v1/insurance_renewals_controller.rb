class Mobile::V1::InsuranceRenewalsController < ApplicationController
  before_action :set_insurance_renewal, only: [:show, :update, :destroy]
 
  def show
    render json: @insurance_renewal
  end

  # POST /web/v1/insurance_renewals
  # POST /web/v1/insurance_renewals.json
  def create
    @insurance_renewal = InsuranceRenewal.new(insurance_renewal_params)

    if @insurance_renewal.save
      template = NotificationTemplate.where(category: I18n.t('Notification.insurance_renewal')).last
      Notification.create(recipient: current_user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template)
      render json: @insurance_renewal, status: :created
    else
      render json: @insurance_renewal.errors, status: :unprocessable_entity
    end
  end

  private

    def set_insurance_renewal
      @insurance_renewal = InsuranceRenewal.find(params[:id])
    end

    def insurance_renewal_params
      params.require(:insurance_renewal).permit(:name, :email, :mobile, :address, :bike, :purchase_date, :registration_number, :insurance_company, :policy_number, :expiry_date, :engine_number, :kms)
    end
end
