class Web::V1::InsuranceRenewalsController < ApplicationController
  before_action :set_insurance_renewal, only: [:show, :update, :destroy]

  # GET /web/v1/insurance_renewals
  # GET /web/v1/insurance_renewals.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @insurance_renewals = InsuranceRenewal.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @insurance_renewals
  end

  # GET /web/v1/insurance_renewals/1
  # GET /web/v1/insurance_renewals/1.json
  def show
    render json: @insurance_renewal
  end

  # POST /web/v1/insurance_renewals
  # POST /web/v1/insurance_renewals.json
  def create
    @insurance_renewal = InsuranceRenewal.new(insurance_renewal_params)
    if @insurance_renewal.save
      template = NotificationTemplate.where(category: I18n.t('Notification.insurance_renewal')).last
      user = User.find_by_email(@insurance_renewal.email)
      Notification.create(recipient: user, actor: current_user, action: 'Bookings', notifiable: @service_booking, notification_template: template) if user
      render json: @insurance_renewal, status: :created
    else
      render json: @insurance_renewal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/insurance_renewals/1
  # PATCH/PUT /web/v1/insurance_renewals/1.json
  def update
    @insurance_renewal = InsuranceRenewal.find(params[:id])

    if @insurance_renewal.update(insurance_renewal_params)
      head :no_content
    else
      render json: @insurance_renewal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/insurance_renewals/1
  # DELETE /web/v1/insurance_renewals/1.json
  def destroy
    @insurance_renewal.destroy

    head :no_content
  end

  private

    def set_insurance_renewal
      @insurance_renewal = InsuranceRenewal.find(params[:id])
    end

    def insurance_renewal_params
      params.require(:insurance_renewal).permit(:name, :email, :mobile, :address, :bike, :purchase_date, :registration_number, :insurance_company, :policy_number, :expiry_date, :kms, :status)
    end
end
