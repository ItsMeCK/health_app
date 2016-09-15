class ApplicationController < ActionController::API
	# include ::ActionController::Serialization
	# include ActiveModel::Serialization
	# after_action :set_access_control_headers
	before_filter :authenticate_user!
	#rescue_from StandardError, with: :standard_error
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

	def audit(object, user)
    audit = object.audits.last
    audit.user_id = user.id
    audit.save	
	end

# private

 # def set_access_control_headers
 #   headers['Access-Control-Allow-Origin'] = "*"
 #   headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
 # end
	def standard_error(exception)
		logger.info "=============Error:: #{exception.backtrace.join("\n")}========================="
		render json: {errors: I18n.t('Errors.500_error')}, status: 500
	end
end