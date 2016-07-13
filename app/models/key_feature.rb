class KeyFeature < ActiveRecord::Base
	belongs_to :bike
	belongs_to :key_feature_type
end
