class ApplicationController < ActionController::API
	# include ::ActionController::Serialization
	# include ActiveModel::Serialization
	# after_action :set_access_control_headers
	
	def default_serializer_options
    {module_namespace: self.class.name.deconstantize}
  end

# private

 # def set_access_control_headers
 #   headers['Access-Control-Allow-Origin'] = "*"
 #   headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
 # end

end