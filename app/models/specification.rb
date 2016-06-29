class Specification < ActiveRecord::Base
	belongs_to :specification_type
	belongs_to :bike
end
