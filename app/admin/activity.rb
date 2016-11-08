ActiveAdmin.register Activity do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :imageable_id, :imageable_type, :image, :name, :description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
	f.inputs "Activity" do 
	  f.input :imageable, collection: ModernDincharya.all 
	  f.input :imageable, collection: AyurvedaDincharya.all
	  f.input :imageable_type, :required => true, :as => :radio, collection: ["ModernDincharya", "UserDincharya"]
	  f.input :name
	  f.input :description
	end
	f.actions
end     
end
