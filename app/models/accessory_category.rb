class AccessoryCategory < ActiveRecord::Base
	audited
	has_many :accessories

	mount_base64_uploader :image, ImageUploader, file_name: 'accessory_category'
end
