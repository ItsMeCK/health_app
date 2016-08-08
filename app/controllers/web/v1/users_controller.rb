class Web::V1::UsersController < ApplicationController
	# before_filter :authenticate_user!
	respond_to :json

	def index
		@users = User.all.order("updated_at DESC").order("created_at DESC")
		render json: @users.includes(:profile), status: 200, each_serializer: Web::V1::UserSerializer
	end

	def create
		@user = User.new(user_params)
		if @user.save
			Notification.create(recipient: @user, actor: current_user, action: I18n.t('Notification.welcome'), notifiable: @user)			
			render json: @user, status: 201, location: [:web, @user], serializer: Web::V1::UserSerializer
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def show
		respond_with User.find(params[:id]), serializer: Web::V1::UserSerializer
	end

	def update
		@user = User.find(params[:id])
	  if @user.update(user_params)
	    render json: @user, status: 200, location: [:web, @user], serializer: Web::V1::UserSerializer
	  else
	    render json: { errors: @user.errors }, status: 422
	  end
	end

	def destroy
	  @user = User.find(params[:id]).destroy
	  message = "Your account has been successfully deleted"
	  render json: { message: message}, status: 204
	end

	def notification_count
  	@user = User.find_by_id(params[:user_id])
  	@count = @user.notification_count
  	respond_to do |f|
  		f.json { render json: @count}
  	end
	end

	def clear_notification_count
		@user = User.find_by_id(params[:user_id])
  	@count = @user.notification_count.destroy
  	message = "Your notification has been successfully cleared"
	  render json: { message: message}, status: 204
	end	

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :role)
	end

end