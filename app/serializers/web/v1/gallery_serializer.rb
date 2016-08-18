class Web::V1::GallerySerializer < ActiveModel::Serializer
   attributes :id, :bike_id, :image, :bike_name

   def bike_name
   	 object.bike.try(:name)
   end

end