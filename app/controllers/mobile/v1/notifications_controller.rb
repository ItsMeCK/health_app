class Mobile::V1::NotificationsController < ApplicationController
	respond_to :json

	def destroy
		Notification.find(params[:id]).destroy
		message = "Notification has been successfully deleted"
		render json: { message: message}, status: 204
	end

	def mark_as_read
		notification = Notification.find(params[:id])
		notification.update(status: true)
		render json: {message: "Marked as read"}, status: 200
	end
	
end
