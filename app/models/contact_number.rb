class ContactNumber < ActiveRecord::Base
	belongs_to :contact_type


	def contact_type_name
      ContactType.find(self.contact_type_id).label
	end
	
	def as_json(options={})
		super.as_json(options).merge({:contact_type_name => contact_type_name})
	end
end
