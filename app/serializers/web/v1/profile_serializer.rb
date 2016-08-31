class Web::V1::ProfileSerializer < ActiveModel::Serializer
  attributes :full_name, :mobile, :dob, :email, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id

  def attributes
  	data = super
  	data[:role] = object.user.role
  	data
  end
end
