class ApplicationController < ActionController::API
	# include ::ActionController::Serialization
	# include ActiveModel::Serialization
	# after_action :set_access_control_headers
	before_filter :set_host

	def set_host
		ActionMailer::Base.default_url_options[:host] = request.host_with_port
	end
	
	def default_serializer_options
		{module_namespace: self.class.name.deconstantize}
	end

	def current_user 
		logger.info "=========Current User======="
		User.where(authentication_token: params["auth_token"]).first
	end

# private

 # def set_access_control_headers
 #   headers['Access-Control-Allow-Origin'] = "*"
 #   headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
 # end

end