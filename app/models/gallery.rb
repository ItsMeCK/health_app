class Gallery < ActiveRecord::Base
	serialize :image
	belongs_to :bike
end
