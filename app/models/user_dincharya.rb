class UserDincharya < ActiveRecord::Base
	belongs_to :user
	validates :title, uniqueness: { case_sensitive: false }
end
