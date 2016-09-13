class SetRule < ActiveRecord::Base
	audited
	serialize :days
end
