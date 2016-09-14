class ContactNumber < ActiveRecord::Base
	audited
	belongs_to :contact_type


	def contact_type_name
		ContactType.find_by_id(self.contact_type_id).try(:label) || "abc"
	end
	
	def as_json(options={})
		super.as_json(options).merge({:contact_type_name => contact_type_name})
	end
end
