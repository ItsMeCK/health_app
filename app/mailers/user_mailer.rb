class UserMailer < ApplicationMailer
   default from: "admin@myridz.com"

	def send_notification_mail(user, notification_type)
	  @notification_template = NotificationTemplate.find_by_category(notification_type)
      mail :to => user.email, :subject => @notification_template.title, :body =>"this is the body"
	end
end
