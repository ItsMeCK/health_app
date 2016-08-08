class DealerContactNumber < ActiveRecord::Base
	belongs_to :dealer
	belongs_to :dealer_contact_label

	def dealer_label_name
      DealerContactLabel.find(self.dealer_contact_label_id).label_name
	end

	def dealer_name
      Dealer.find(self.dealer_id).dealer_name
	end
	
	def as_json(options={})
		super.as_json(options).merge({:dealer_label_name => dealer_label_name, :dealer_name => dealer_name})
	end
end
