class Mobile::V1::AyurvedaDincharyaSerializer < ActiveModel::Serializer
  attributes :id, :sleep_time, :wake_up_time, :break_fast_time, :lunch, :snacks_time, :sports, :hobbies, :dinner
end
