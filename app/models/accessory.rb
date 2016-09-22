class Accessory < ActiveRecord::Base
	audited
	has_many :wishlists, :through => :accessory_wishlist
	belongs_to :accessory_category

	has_many :tags, through: :accessory_tags
	has_many :accessory_tags, dependent: :destroy
	mount_base64_uploader :image, ImageUploader, file_name: 'accessory'

	def get_accessory_category_name
		self.accessory_category.try(:title) || 'NA'
	end

	def as_json(options={})
		super.as_json(options).merge({:accessory_category_name => get_accessory_category_name})
	end
end
