class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :bike_image, :display_order, :pricing, :brand
 
  def bike_image
     object.default_bike_image.try(:image_url)
  end 

  def pricing
  	object.try(:bike_price)
  	  #object.pricings.collect { |price| price.price_field }.map! { |price_field| price_field if price_field.name == "Ex-Showroom"}.compact
  end

end