class DealerType < ActiveRecord::Base
	audited
	has_and_belongs_to_many :dealers
end
