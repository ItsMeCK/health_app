class Mobile::V1::UsersController < ApplicationController
	respond_to :json
	before_action :set_user only: [:create, :show, :update, :destroy]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user, status: 201, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def show
		respond_with User.find(params[:id]), serializer: Mobile::V1::UserSerializer
	end

	def update
	  @user = User.find(params[:id])
	  if @user.update(user_params)
	    render json: @user, status: 200, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
	  else
	    render json: { errors: @user.errors }, status: 422
	  end
	end

	def destroy
	  @user = User.find(params[:id])
	  @user.destroy
	  message = "Your account has been successfully deleted"
	  render json: { message: message}, status: 204
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end