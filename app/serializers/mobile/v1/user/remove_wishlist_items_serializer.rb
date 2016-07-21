class Mobile::V1::User::RemoveWishlistItemsSerializer < ActiveModel::Serializer
	attributes :id, :title, :description, :tag, :image, :accessory_category_id, :part_number, :size, :price
	def attributes
		data = super
		if current_user.wishlist.accessories.pluck(:id).include? data[:id]
		#current_user.wishlist.accessories.each do 
		data[:active] = "false"
		data
	else
		data[:active] = "true"
		data
	end  
end
end
