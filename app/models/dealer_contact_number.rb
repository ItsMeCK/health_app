class DealerContactNumber < ActiveRecord::Base
	belongs_to :dealer
	belongs_to :dealer_contact_label
end
