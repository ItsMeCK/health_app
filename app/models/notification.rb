class Notification < ActiveRecord::Base

# Associations
	belongs_to :recipient, class_name: "User"
	belongs_to :actor, class_name: "User"
	belongs_to :notifiable, polymorphic: true

# Methods

	# def self.notify
	# 	n = Rpush::Gcm::Notification.new
	# 	n.app = Rpush::Gcm::App.find_by_name("coromandal_harley_davidson")
	# 	n.registration_ids = ["..."]
	# 	n.data = { message: "Hello World!" }
	# 	n.priority = 'high'        # Optional, can be either 'normal' or 'high'
	# 	n.content_available = true # Optional
	# 	n.notification = { body: 'great match!', title: 'Portugal vs. Denmark', icon: 'myicon' }
	# 	n.save!
	# end


	# def reminder

	# end

end
