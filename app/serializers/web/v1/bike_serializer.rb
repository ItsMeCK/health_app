class Web::V1::BikeSerializer < ActiveModel::Serializer
	attributes :id, :name, :bike_image, :display_order, :pricing
	
	def bike_image
		object.default_bike_image.try(:image_url)
	end 

	def pricing
		object.try(:bike_price)
	end
	


end