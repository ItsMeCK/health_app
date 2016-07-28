class Bike < ActiveRecord::Base
	belongs_to :bike_type
	has_one :default_bike_image
	has_many :specifications
	has_many :key_features
	has_many :pricings
	has_many :bike_colors
	has_many :service_schedules


    def bike_type_name
    	self.bike_type.try(:name)
    end

    def bike_image_url
    	self.default_bike_image.try(:image_url)
    end

	def bike_specifications
		@specifications = []
		self.specifications.each do |specification|
			@specification_name = SpecificationType.find_by_id(specification.specification_type_id).name
			@specifications << Hash[@specification_name, specification]
		end
	  @specifications.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[specification_type: k, values: v.map(&:last)]}
	end

	def key_feature
		@key_features = []
		self.key_features.each do |key_feature|
			@key_feature_name = KeyFeatureType.find_by_id(key_feature.key_feature_type_id).try(:feature_type_name)
			@key_features << Hash[@key_feature_name, key_feature]
		end
	  @key_features.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[key_feature_type: k, values: v.map(&:last)]}
	end

	def pricing
		@pricings = []
		self.pricings.each do |price|
			@price_field_name = PriceField.find_by_id(price.price_field_id).try(:name)
			@pricings << Hash[@price_field_name, price]
		end
	  @pricings.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[price_field_type: k, values: v.map(&:last)]}
	end

	def bike_color
		self.bike_colors
	end

	def as_json(options={})
		super.as_json(options).merge({:bike_type_name => bike_type_name, :bike_image_url => bike_image_url, :specifications => bike_specifications, :key_features => key_feature, :price => pricing, :bike_colors => bike_color })
	end

end
