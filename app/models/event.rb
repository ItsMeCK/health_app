class Event < ActiveRecord::Base
	has_many :users, through: :user_events
	has_many :user_events

	after_create :create_user_event
	before_destroy :destroy_user_event

	def call_notification(notification_template, email_template)
    users = User.all
    users.each do |user|
      self.event_notification(user, notification_template, email_template)
    end
   end

	def event_notification(user, notification_template, email_template)
		user_event = user.user_events.where(event_id: self.id)
		template = NotificationTemplate.where(category: notification_template).last
    Notification.create(recipient: user, actor: user, action: 'Events', notifiable: self, notification_template: template)
    UserMailer.notification_mail_for_event(user, self, email_template).deliver
	end	

	private

	def create_user_event
		@users = User.all
		@users.each do |user|
			self.user_events.create(event_id: self.id, user_id: user.id, perticipate_event: "Not Replied")
		end
	end

	def destroy_user_event
		@user_event = UserEvent.where(event_id: self.id)
		@user_event.each do |event|
			event.delete
		end
	end
end
