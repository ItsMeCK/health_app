class Tag < ActiveRecord::Base
	has_many :accessories, through: :accessory_tags
	has_many :accessory_tags
	mount_base64_uploader :image, ImageUploader, file_name: 'tag'
end
