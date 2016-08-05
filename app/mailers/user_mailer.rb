class UserMailer < ApplicationMailer
   default from: "admin@myridz.com"

	def send_notification_mail(user, notification_type)
	  @notification_template = NotificationTemplate.find_by_category(notification_type)
      mail :to => user.email, :subject => @notification_template.try(:title), :body =>"this is the body"
	end

	def notification_mail_for_ride(user)
		 mail :to => user.email, :subject => "New Ride Invitation", :body =>"this is the new ride invitation you should be perticipated on this one please accept invitation"
	end

	def notification_mail_for_event(user)
		 mail :to => user.email, :subject => "New Event Invitation", :body =>"this is the new event invitation you should be perticipated on this one please accept invitation"
	end

end
