class Web::V1::UsersController < ApplicationController
	respond_to :json

	def index
		@users = User.all
		render json: @users, serializer: UserSerializer, status: 200
	end

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user, status: 201, location: [:web, @user], serializer: UserSerializer
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def show
		respond_with User.find(params[:id]), serializer: UserSerializer
	end

	def update
		@user = User.find(params[:id])
	  if @user.update(user_params)
	    render json: @user, status: 200, location: [:web, @user], serializer: UserSerializer 
	  else
	    render json: { errors: @user.errors }, status: 422
	  end
	end

	def destroy
	  @user = User.find(params[:id]).destroy
	  message = "Your account has been successfully deleted"
	  render json: { message: message}, status: 204
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end