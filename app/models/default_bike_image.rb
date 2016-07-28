class DefaultBikeImage < ActiveRecord::Base
	belongs_to :bike
	has_many :my_bikes
end
