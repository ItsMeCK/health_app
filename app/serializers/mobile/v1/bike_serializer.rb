class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :tagline, :description
  has_many :specifications, serializer: Mobile::V1::SpecificationSerializer 
  
def specifications
	binding.pry
    #object.places.order("title")
end

end