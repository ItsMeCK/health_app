class Event < ActiveRecord::Base
	has_many :users, through: :user_events
	has_many :user_events

	after_create :create_user_event
	before_destroy :destroy_user_event

	private

	def create_user_event
		@users = User.all
		@users.each do |user|
			self.user_events.create(event_id: self.id, user_id: user.id, perticipate_event: "Not Replied", user_event_date: self.event_date)
		end
	end

	def destroy_user_event
		@user_event = UserEvent.where(ride_id: self.id)
		@user_event.each do |event|
			event.delete
		end
	end
end
