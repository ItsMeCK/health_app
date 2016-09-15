class Web::V1::ProfileSerializer < ActiveModel::Serializer
  attributes :full_name, :mobile, :dob, :email, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id

  def attributes
  	data = super
  	data[:role] = object.user.role
  	data[:android_token] = object.user.try(:android_token)
  	data[:ios_token] = object.user.try(:ios_token)
  	data
  end
end
