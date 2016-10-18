class Mobile::V1::UserDincharyasController < InheritedResources::Base


  def populate_dincharya
  	@din = current_user.user_dincharya
  	if params[:category] == 'ayurveda'
  		@din.update(AyurvedaDincharya.first.attributes)
  	else
  		@din.update(Modern.first.attributes)  		
  	end	

  	render json: @din, {message: "Added"}
  end	

  private

    def user_dincharya_params
      params.require(:user_dincharya).permit(:sleep_time, :wake_up_time, :break_fast_time, :lunch, :snacks_time, :sports, :hobbies, :dinner)
    end
end

