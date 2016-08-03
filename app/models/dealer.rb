class Dealer < ActiveRecord::Base
	serialize :dealer_type_id
	has_and_belongs_to_many :dealer_types
	has_many :dealer_contact_numbers

	#mount_base64_uploader :image, ImageUploader, file_name: 'dealer'
	#call back
	#after_create :create_joint_table

	
	def dealer_tyep_name	
		if self.dealer_type_id.class == Array
		  @dealer_type_ids = self.dealer_type_id
	     else
	     	@dealer_type_ids = [self.dealer_type_id]
	     end
		@dealer = []
		@dealer_type_ids.each do |id|
		 @dealer << DealerType.find(id).try(:dealer_type) if id 
	    end
	    @dealer
	end

	def as_json(options={})
		super.as_json(options).merge({:dealer_type => dealer_tyep_name})
	end

	def create_joint_table
		@dealer_type = DealerType.find(self.dealer_type_id)
		self.dealer_types << @dealer_type
	end
end
