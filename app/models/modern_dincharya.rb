class ModernDincharya < ActiveRecord::Base
	has_many :activities, as: :imageable
end
