class Mobile::V1::ProfilesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy]


  # GET /profiles/1
  # GET /profiles/1.json
  def show
    render json: @profile
  end

  # POST /profiles
  # POST /profiles.json
  # def create
  #   @profile = Profile.new(profile_params)

  #   if @profile.save
  #     render json: @profile, status: :created, location: @profile
  #   else
  #     render json: @profile.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      current_user.hog_registration.update(profile_params.except(:marriage_anniversary_date))
      render json: @profile, status: :ok
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def update_profile_image
   @profile = Profile.find(params[:id])
   @profile.remove_profile_image! if @profile.profile_image
   if @profile.update(profile_params)
     @profile.profile_image = params[:profile][:profile_image]
     @profile.save
     render json: @profile, status: :ok
   else
    render json: @profile.errors, status: :unprocessable_entity
  end
end



  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy

    head :no_content
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:full_name, :mobile, :email, :dob, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id, :marriage_anniversary_date)
  end
end
