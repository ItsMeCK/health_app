class Accessory < ActiveRecord::Base
	has_many :wishlists, :through => :accessory_wishlist
	belongs_to :accessory_category

	mount_base64_uploader :image, ImageUploader, file_name: 'accessory'
end
