class Pricing < ActiveRecord::Base
	belongs_to :bike
	belongs_to :price_field
end
