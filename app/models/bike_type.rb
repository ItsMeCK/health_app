class BikeType < ActiveRecord::Base
	audited
  has_many :bikes
end
