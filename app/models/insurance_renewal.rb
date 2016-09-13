class InsuranceRenewal < ActiveRecord::Base
	audited

	def send_insurance_notification
			template = NotificationTemplate.where(category: I18n.t('Notification.insurance_renewal')).last
      user = User.find_by_email(self.email)
      if user
      	Notification.create(recipient: user, actor: current_user, action: 'Bookings', notifiable: self, notification_template: template)
      	UserMailer.insurance_renewal(self).deliver
     		UserMailer.insurance_renewal_confirm(self).deliver	
    	end
	end	
end
