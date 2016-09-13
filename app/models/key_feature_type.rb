class KeyFeatureType < ActiveRecord::Base
	audited
	has_many :key_features
end
