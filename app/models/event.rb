class Event < ActiveRecord::Base
	has_many :users, through: :user_events
	has_many :user_events

	after_create :create_user_event

	private

	def create_user_event
		@users = User.all
		@users.each do |user|
			self.user_events.create(event_id: self.id, user_id: user.id, perticipate_event: "Not Replied", user_event_date: self.event_date)
		end
	end
end
