class Accessory < ActiveRecord::Base
	has_many :wishlists, :through => :accessory_wishlist
	has_many :users, :through => :accessory_enquiry
	belongs_to :accessory_category

	mount_base64_uploader :image, ImageUploader, file_name: 'accessory'
end
