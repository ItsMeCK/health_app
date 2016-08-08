class Web::V1::NotificationsController < ApplicationController

	def create_bulk_notification
		users = params[:notification][:users]
		action = params[:notification][:action]
		Notification.delay.send_bulk_notification users, action
		
		head status: 200 
	end	

end
