class AyurvedaDincharya < ActiveRecord::Base
	has_many :activities, as: :imageable
end
