class Activity < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	#attr_accessible :imageable_id, :imageable_type
end
