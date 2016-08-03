class ContactType < ActiveRecord::Base
	has_many :contact_numbers
end
