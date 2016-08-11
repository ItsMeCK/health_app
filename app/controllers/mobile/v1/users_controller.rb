class Mobile::V1::UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update, :show, :destroy, :update_wishlist_items, :remove_wishlist_items, :get_wishlist_items]
	respond_to :json
	# before_action :set_user, only: [:show, :update, :destroy]

	def create
		@user = User.new(user_params)
		if @user.save
			Notification.create(recipient: @user, actor: current_user, action: I18n.t('Notification.welcome'), notifiable: @user)
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
		puts "================#{current_user.inspect}"
  	@count = current_user.notification_count
  	respond_to do |f|
  		f.json { render json: @count}
  	end
	end

	def notification_by_category
		@notifications = current_user.notifications.where(action: params[:category])
		render json: @notifications
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
		params.require(:user).permit(:email, :password, :password_confirmation, :android_token, :ios_token)
	end

end