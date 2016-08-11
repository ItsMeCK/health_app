class Mobile::V1::SessionsController < ApplicationController
  before_filter :authenticate_user!, only: [:destroy]

	def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)
    if user.present?
      if user.valid_password? user_password
        sign_in user, store: false
        user.update_device_token(params)
        user.save
        render json: user, status: 200, location: [:mobile, user]
      else
        render json: { errors: "Invalid email or password" }, status: 422
      end
    else
      render json: {message: "Invalid Registration"}, status: 422
    end

  end

  def destroy
    user = User.find_by(authentication_token: params[:auth_token])
    user.reset_authentication_token!
    user.save
    message = "You have been successfully signed out"
    render json: user, status: 204, location: [:mobile, user]
  end

end