class Mobile::V1::SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token
end
