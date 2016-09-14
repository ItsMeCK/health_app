class Mobile::V1::UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update, :show, :destroy, :update_wishlist_items, :remove_wishlist_items, :get_wishlist_items]
	respond_to :json
	# before_action :set_user, only: [:show, :update, :destroy]

	def create
		@user = User.new(user_params)

		if params[:user][:social_login] == 1 
			user_email = params[:user][:email]
			user = user_email.present? && User.find_by(email: user_email)
			if user.present?
				sign_in user, store: false
				user.update_device_token_with_social(params)
				user.save
			   render json: user, status: 200
			else
				@user.save(validate: false)
				render json: @user, status: 201, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
				users_creation(params)
				users_social_login(params)
			end
		elsif @user.save
			render json: @user, status: 201, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
			users_creation(params)	
		else
			render json: { errors: @user.errors}, status: 422
		end
	end

	def users_creation(params)
		template = NotificationTemplate.where(category: I18n.t('Notification.welcome')).last
		mobile = params[:user][:mobile] || 0
		name = params[:user][:name]
		Profile.create( user_id: @user.id, email: @user.email, full_name: name, mobile: mobile)
		HogRegistration.create( user_id: @user.id, email: @user.email, full_name:name, mobile: mobile)
		Notification.create(recipient: @user, actor: current_user, action: 'Offer', notifiable: @user, notification_template: template)
		#UserMailer.welcome_user(@user).deliver
		#render json: @user, status: 201, location: [:mobile, @user], serializer: Mobile::V1::UserSerializer
	end

	def users_social_login(params)
		user_email = params[:user][:email]
		user = user_email.present? && User.find_by(email: user_email)
		if user.present?
			if params[:user][:social_login] == 1
				sign_in user, store: false
				binding.pry
				user.update_device_token_with_social(params)
				user.save
			else
				render json: { errors: "Invalid Registration" }, status: 422
			end
		else
			render json: {message: "Invalid Registration"}, status: 422
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

	def update_wishlist_items
		accessories = params[:accessory_ids]
		wishlist_id = current_user.wishlist.id
		accessories.each do |accessory|
			AccessoryWishlist.create(accessory_id: accessory, wishlist_id: wishlist_id)
		end
	end

	def get_wishlist_items
		@accessories = current_user.wishlist.accessories
		render json: @accessories
	end

	def remove_wishlist_items
		@accessory = params[:accessory_ids]
		@accessory.each  do |accessory_id|
			AccessoryWishlist.where(wishlist_id: current_user.wishlist.id).find_by_accessory_id(accessory_id).delete
		end
		#message = "Removed From Wishlist"
		@remaining_accessories = current_user.wishlist.accessories
		 render json: @remaining_accessories #,each_serializer: Mobile::V1::User::RemoveWishlistItemsSerializer
		end

		def notification_count
			@count = current_user.notification_count
			logger.info "=====================#{@count.inspect}=========="
			@count.reload if @count
			render json: @count
		end

		def notification_by_category
			@notifications = current_user.notifications.where(action: params[:category]).order("updated_at DESC").order("created_at DESC") 
			render json: @notifications, each_serializer: Mobile::V1::NotificationSerializer
		end	

		def clear_notification_count
			@count = current_user.notification_count.reset_count_for_category(params[:category])
			message = "Your notification has been successfully cleared"
			render json: { message: message}, status: 204
		end	

		private

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :android_token, :ios_token, :social_login)
		end

	end