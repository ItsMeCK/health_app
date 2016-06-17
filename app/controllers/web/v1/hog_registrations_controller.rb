class Web::V1::HogRegistrationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hog_registration, only: [:show, :update, :destroy]

  # GET /hog_registrations
  # GET /hog_registrations.json
  def index
    @hog_registrations = HogRegistration.all

    render json: @hog_registrations
  end

  # GET /hog_registrations/1
  # GET /hog_registrations/1.json
  def show
    render json: @hog_registration
  end

  # POST /hog_registrations
  # POST /hog_registrations.json
  def create
    @hog_registration = HogRegistration.new(hog_registration_params)

    if @hog_registration.save
      render json: @hog_registration, status: :created, location: [:web, @hog_registration]
    else
      render json: @hog_registration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hog_registrations/1
  # PATCH/PUT /hog_registrations/1.json
  def update
    @hog_registration = HogRegistration.find(params[:id])

    if @hog_registration.update(hog_registration_params)
      render json: @hog_registration, status: :ok, location: [:web, @hog_registration]
    else
      render json: @hog_registration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hog_registrations/1
  # DELETE /hog_registrations/1.json
  def destroy
    @hog_registration.destroy

    head :no_content
  end

  private

    def set_hog_registration
      @hog_registration = HogRegistration.find(params[:id])
    end

    def hog_registration_params
      params.require(:hog_registration).permit(:full_name, :mobile, :dob, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image)
    end
end
