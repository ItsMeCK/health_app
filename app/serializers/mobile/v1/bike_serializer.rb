class Mobile::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :tagline, :description
  has_many :specifications

  

end