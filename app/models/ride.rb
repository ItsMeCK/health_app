class Ride < ActiveRecord::Base
	has_many :users, through: :user_rides
	has_many :user_rides
	#serialaizer
	serialize :assembly_time
	serialize :destination_time
	serialize :check_points


	after_create :create_user_ride
	before_destroy :destroy_user_ride

	def call_notification(notification_template, email_template)
    users = User.all
    users.each do |user|
      @ride.ride_notification(user, notification_template, email_template)
    end
   end

  def ride_notification(user, notification_template, email_template)
		template = NotificationTemplate.where(category: notification_template).last
    Notification.create(recipient: user, actor: current_user, action: 'Events', notifiable: self, notification_template: template)
    UserMailer.notification_mail_for_ride(user, self, email_template).deliver
	end	
 

	private

	def create_user_ride
		@users = User.all
		@users.each do |user|
			self.user_rides.create(ride_id: self.id, user_id: user.id, perticipate_ride: "Not Replied", user_ride_date: self.ride_date)
		end
	end

	def destroy_user_ride
		@user_ride = UserRide.where(ride_id: self.id)
		@user_ride.each do |ride|
			ride.delete
		end
	end
end
