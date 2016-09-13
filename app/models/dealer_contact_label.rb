class DealerContactLabel < ActiveRecord::Base
	audited
	has_many :dealer_contact_numbers
end
