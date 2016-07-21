class AccessoryEnquiry < ActiveRecord::Base
	belongs_to :user
	belongs_to :accessory
end
