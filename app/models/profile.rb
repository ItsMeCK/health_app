class Profile < ActiveRecord::Base
	belongs_to :user

	mount_base64_uploader :profile_image, ImageUploader, file_name: 'profile'
end
