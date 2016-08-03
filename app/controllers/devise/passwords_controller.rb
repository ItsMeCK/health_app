class Devise::PasswordsController < ActionController::Base
  def edit
	 	@token = params[:reset_password_token]
  	@user = User.find_by_reset_password_token(@token)
	 	render 'passwords/reset_password.html.erb'
  end

  def update_password
  	@user = User.find params[:user][:user]
  	@user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
  	if @user.update(user_params)
  		reset_auth_token
	    render text: 'Password is Updated Successfully'
	  else
	    render 'passwords/reset_password.html.erb'
	  end
  end	

  private

  def reset_auth_token
  	@user.reset_authentication_token!
    @user.save
  end
  	
	def user_params
		params.require(:user).permit(:password, :password_confirmation)
	end
end  	