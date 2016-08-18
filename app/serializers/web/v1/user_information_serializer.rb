class Web::V1::UserInformationSerializer < ActiveModel::Serializer
   attributes :id, :user_id, :ride_id, :perticipate_ride, :user_ride_date, :user_name, :user_email, :user_number

  def user_name
  	object.user.profile.try(:full_name)
  end

   def user_email
  	object.user.email
  end

   def user_number
  	object.user.profile.try(:mobile)
   end

end