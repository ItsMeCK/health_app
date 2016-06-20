class Web::V1::SpecificationSerializer < ActiveModel::Serializer
  belongs_to :bike
  attributes :bike_id, :pricing, :dimensions, :engine, :drivetrain, :chassis, :performance, :electric
end
