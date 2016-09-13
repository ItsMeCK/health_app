class ContactType < ActiveRecord::Base
	audited
	has_many :contact_numbers
end
