ActiveAdmin.register AyurvedaDincharya do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu :parent => "Dincharya"
  action_item only: :show  do
	link_to "New AyurvedaDincharya", action: :new # so link will only be available on show action
  end
permit_params :title, :reminder_time, :description
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
