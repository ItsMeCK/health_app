class AccessoryWishlist < ActiveRecord::Base
	belongs_to :wishlist
	belongs_to :accessory
end
