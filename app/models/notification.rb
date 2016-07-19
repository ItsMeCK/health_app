class Notification < ActiveRecord::Base

# Associations
	belongs_to :recipient, class_name: "User"
	belongs_to :actor, class_name: "User"
	belongs_to :notifiable, polymorphic: true
	after_create :send_notification

# Methods

	def send_notification
		@user = self.recipient
		@notification_type = self.action
		# @notification_template = NotificationTemplate.find_by_category(@notification_type)
		# if @notification_template.active == true	
			if @user.android_token.present?
				n = Rpush::Gcm::Notification.new
				n.app = Rpush::Gcm::App.find_by_name("coromandal_harley_davidson")
				n.registration_ids = [@user.android_token]
				n.data = { message: "Hello World" }
				n.priority = 'high'        # Optional, can be either 'normal' or 'high'
				n.content_available = true # Optional
				# n.notification = { body: @notification_template.content, title: @notification_template.title, icon: 'myicon' }
				n.save!
			end
			# if @user.ios_token.present?
			# 	n = Rpush::Apns::Notification.new
			# 	n.app = Rpush::Apns::App.find_by_name("coromandal_harley_davidson")
			# 	n.device_token = "..." # 64-character hex string
			# 	n.alert = "You have a notification"
			# 	n.data = { foo: :bar }
			# 	n.save!
			# end
		# end
		
		UserMailer.send_notification_mail(@user, @notification_type).deliver
	end


	# def reminder

	# end

end
