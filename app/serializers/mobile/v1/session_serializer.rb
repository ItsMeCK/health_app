class Mobile::V1::SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :role, :sign_in_count
end
