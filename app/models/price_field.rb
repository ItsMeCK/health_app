	class PriceField < ActiveRecord::Base
		audited
		has_many :pricings
	end
