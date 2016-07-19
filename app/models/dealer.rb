class Dealer < ActiveRecord::Base
	has_and_belongs_to_many :dealer_types

	mount_base64_uploader :image, ImageUploader, file_name: 'dealer'
	#call back
	after_create :create_joint_table

	def create_joint_table
		@dealer_type = DealerType.find(self.dealer_type_id)
		self.dealer_types << @dealer_type
	end
end
