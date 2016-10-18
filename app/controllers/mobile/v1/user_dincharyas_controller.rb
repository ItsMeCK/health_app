class Mobile::V1::UserDincharyasController < InheritedResources::Base


  def populate_dincharya
    user = current_user
  	if params[:category] == 'ayurveda'
      AyurvedaDincharya.all.each do |din|
        begin
          u_din = UserDincharya.find_by_title(din.title)
          u_din = UserDincharya.new(title: din.title) unless u_din
          u_din.reminder_time = din.reminder_time
          u_din.user_id = user.id
          u_din.save
        rescue StandardError => e 
          logger.info "====#{e.message}======="
          next
        end  
      end
  	else
  		ModernDincharya.all.each do |din|
        begin
          u_din = UserDincharya.find_by_title(din.title)
          u_din = UserDincharya.new(title: din.title) unless u_din
          u_din.reminder_time = din.reminder_time
          u_din.user_id = user.id
          u_din.save
        rescue StandardError => e 
          logger.info "====#{e.message}======="
          next
        end  
      end
  	end	

  	render json: {message: "Added"}
  end


  def create
    @user_dincharya = UserDincharya.new(user_dincharya_params)

    if @user_dincharya.save
      render json: @user_dincharya, status: :created
    else
      render json: @user_dincharya.errors, status: :unprocessable_entity
    end
  end

  def update
    @user_dincharya = UserDincharya.find(params[:id])

    if @user_dincharya.update(user_dincharya_params)
      render json: @user_dincharya, status: :created
    else
      render json: @user_dincharya.errors, status: :unprocessable_entity
    end
  end

  def delete
    UserDincharya.find(params[:id]).destroy
    head :no_content
  end  

  private

    def user_dincharya_params
      params.require(:user_dincharya).permit(:title, :reminder_time, :description, :user_id)
    end
end

