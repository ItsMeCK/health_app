class SpecificationType < ActiveRecord::Base
	audited
	has_many :specifications
end
