class Notification < ActiveRecord::Base

# Associations
	belongs_to :recipient, class_name: "User"
	belongs_to :actor, class_name: "User"
	belongs_to :notifiable, polymorphic: true
	after_create :send_notification
	after_update :send_notification
	belongs_to :notification_template
	# @params user_id, notification_typo
	def send_notification(recipient = nil, action = nil)
		@user = self.recipient || recipient
		@notification_type = self.action || action 
		@notification_template = self.notification_template
		#self.update_attribute(:notification_template, @notification_template) unless self.notification_template_id
		if @user.present?
			if @user.android_token.present?
				android_notification
			end
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

	def self.proactive_insurance_reminder
		@set_rule = SetRule.where(category: 'Insurance renewal').first
		todays_date = Date.today
		template = NotificationTemplate.where(category: I18n.t('Notification.insurance_renewal')).last
		@set_rule.days.each do |day|
			reminder_date = todays_date - day
			MyBike.where(expiry_date:  reminder_day).each do |mybike|
				Notification.create(recipient: mybike.user, actor: mybike.user, action: 'Bookings', notifiable: mybike, notification_template: template)
			end	
		end	
	end	

	def self.proactive_service_booking_reminder
		@set_rule = SetRule.where(category: 'Service booking').first
		todays_date = Date.today
		template = NotificationTemplate.where(category: I18n.t('Notification.service_booking')).last
		@set_rule.days.each do |day|
			reminder_date = todays_date - day
			ServiceBooking.where(date:  reminder_day).each do |service_booking|
				Notification.create(recipient: service_booking.my_bike.user, actor: service_booking.my_bike.user, action: 'Bookings', notifiable: service_booking, notification_template: template)
			end	
		end	
	end

	def self.proactive_test_drive_reminder
		@set_rule = SetRule.where(category: 'Re-active test drive reminders').first
		todays_date = Date.today
		@set_rule.days.each do |day|
			reminder_date = todays_date - day
			TestRide.where(ride_date:  reminder_day).each do |test_ride|
				Notification.create(recipient: test_ride.user, actor: test_ride.user, action: I18n.t('Notification.test_ride_booking'), notifiable: test_ride)
			end	
		end	
	end

	# based on KM and service interval months
	def self.proactive_service_interval
		@set_rule = SetRule.where(category: 'Service Interval').first
		todays_date = Date.today
		@set_rule.days.each do |day|
			reminder_date = todays_date - day.months
			
			MyBike.each do |mybike|
				if mybike.km_exceeds_for_months
					Notification.create(recipient: mybike.user, actor: mybike.user, action: I18n.t('Notification.kms_exceeds'), notifiable: mybike)
				elsif(mybike.purchase_date == reminder_date)
					Notification.create(recipient: mybike.user, actor: mybike.user, action: I18n.t('Notification.service_scheduled'), notifiable: mybike)
				end	
			end
		end	
	end

	def self.proactive_birthday_anniversory_notification
		day  = Date.today.day
		month = Date.today.month
		@profiles = Profile.where('extract(month from dob) = ? and extract(day from dob) = ?', month, day)
		@profiles.each do |profile|
			Notification.create(recipient: profile.user, actor: profile.user, action: I18n.t('Notification.birthday'), notifiable: profile)
		end	
	end	

	def self.send_bulk_notification(users, action, template)
		Notification.skip_callback(:create, :after, :send_notification) 
		@parent  = Notification.create(action: action, notification_template: template)
		Notification.set_callback(:create, :after, :send_notification)
		users.each do |user_id|
			user = User.find user_id
			Notification.create(recipient: user, actor: user, action: action, notifiable: user, parent_id: @parent.id, notification_template: template)
		end	
	end

	def get_notification_tempalte

	end	
	
	private

	def android_notification
		n = Rpush::Gcm::Notification.new
		n.app = Rpush::Gcm::App.find_by_name("coromandal_harley_davidson")
		n.registration_ids = [@user.android_token]
		n.data = { title: @notification_template.title, message: "Tap here to view details", body: @notification_template.content }
		n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		n.content_available = true # Optional
		n.notification = { body: @notification_template.content, title: @notification_template.title, icon: 'myicon' }
		n.save!
		increase_notification_count
	end	

	def increase_notification_count
		NotificationCount.where(user: @user).first_or_create.add_notification_count(self.action)
	end	
end
