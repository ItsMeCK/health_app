class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :tagline, :description
  has_one :specification
  

  

end