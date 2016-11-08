class UserDincharya < ActiveRecord::Base
	belongs_to :user
	validates :title, uniqueness: { case_sensitive: false }
	has_many :activities, as: :imageable
end
