class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :bike_image, :pricing
 
  def bike_image
     object.default_bike_image.try(:image_url)
  end 

  def pricing
  	  object.pricings.collect { |price| price.price_field }.map! { |price_field| price_field if price_field.name == "Ex-Showroom"}.compact
  end

end