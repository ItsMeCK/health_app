class Web::V1::NotificationsController < ApplicationController

	def create_bulk_notification
		users = params[:users] || User.all.pluck(:id)
		NotificationTemplate.create(title: params[:name], content: params[:template], category: params[:category])
		Notification.delay.send_bulk_notification users, params[:category]
		
		head status: 200 
	end	

end
