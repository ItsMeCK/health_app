class Accessory < ActiveRecord::Base
	has_many :wishlists, :through => :accessory_wishlist
	has_one :accessory_category

	mount_base64_uploader :image, ImageUploader, file_name: 'accessory'
end
