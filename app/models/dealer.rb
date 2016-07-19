class Dealer < ActiveRecord::Base
	has_and_belongs_to_many :dealer_types

	mount_base64_uploader :image, ImageUploader, file_name: 'dealer'
end
