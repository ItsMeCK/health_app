class MyDoc < ActiveRecord::Base
	belongs_to :user

	mount_base64_uploader :image, ImageUploader, file_name: 'my_doc'
end
