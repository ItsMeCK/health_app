class UserManualReminderSerializer < ActiveModel::Serializer
  attributes :id, :rem_time, :title, :description
end
