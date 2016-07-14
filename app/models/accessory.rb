class Accessory < ActiveRecord::Base
	has_many :wishlists, :through => :accessory_wishlist
	has_one :accessory_category
end
