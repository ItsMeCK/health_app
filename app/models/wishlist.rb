class Wishlist < ActiveRecord::Base
	has_many :accessories, :through => accessory_wishlist
	belongs_to :user
end
