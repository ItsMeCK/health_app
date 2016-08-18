class Web::V1::UserEventInformationSerializer < ActiveModel::Serializer
   attributes :id, :user_id, :event_id, :perticipate_event, :user_event_date, :user_name, :user_email, :user_number

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