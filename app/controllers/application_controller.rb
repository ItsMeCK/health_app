class ApplicationController < ActionController::Base

	def current_user 
		logger.info "=========Current User======="
		User.where(authentication_token: params["auth_token"]).first
	end
end