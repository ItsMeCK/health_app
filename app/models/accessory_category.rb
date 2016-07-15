class AccessoryCategory < ActiveRecord::Base
	belongs_to :accessory

	mount_base64_uploader :image, ImageUploader, file_name: 'accessory_category'
end
