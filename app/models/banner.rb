class Banner < ActiveRecord::Base
	audited
  mount_base64_uploader :image, ImageUploader, file_name: 'banner'
end
