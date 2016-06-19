class Bike < ActiveRecord::Base
  belongs_to :bike_type
  has_one :specification
end
