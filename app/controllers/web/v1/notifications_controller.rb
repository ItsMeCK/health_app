class Web::V1::NotificationsController < ApplicationController
	respond_to :json
	
	def create_bulk_notification
		users = params[:users] || User.all.pluck(:id)
		template = NotificationTemplate.create(title: params[:name], content: params[:template], category: params[:category])
		Notification.delay.send_bulk_notification users, params[:category], template 
		
		head status: 200 
	end	

	def index
		limit, offset = Calculator.limit_and_offset(params)
		@notifications = Notification.where(parent_id: nil).limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")
		render json: @notifications, each_serializer: Web::V1::NotificationSerializer
	end

	def show
		respond_with Notification.find(params[:id]), serializer: Web::V1::NotificationSerializer
	end

	def destroy
		Notification.find(params[:id]).destroy
		message = "Notification has been successfully deleted"
		render json: { message: message}, status: 204
	end

	def delete_notifications
		@notifications = params[:notification_ids]
		@notifications.each do |notification|
			Notification.find(notification).delete
		end
	end

end
