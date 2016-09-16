class Mobile::V1::MyBikesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_my_bike, only: [:show, :update, :destroy]

  # GET /web/v1/my_bikes
  # GET /web/v1/my_bikes.json
  def index
    @my_bikes = current_user.my_bikes.where(status: 'Active')

    render json: @my_bikes
  end

  # GET /web/v1/my_bikes/1
  # GET /web/v1/my_bikes/1.json
  def show
    render json: @my_bike
  end

  # POST /web/v1/my_bikes
  # POST /web/v1/my_bikes.json
  def create
    @my_bike = MyBike.new(my_bike_params)

    if @my_bike.save
      if @my_bike.bike_image.present?
        if set_host == "localhost:3000"
          @my_bike.update(my_bike_image_url: "http://" + set_host + @my_bike.bike_image.url)
         #@my_bike.update(image_host_url: "http://" + set_host + @my_bike.bike_image.url)
        else
          @my_bike.update(my_bike_image_url: "https://" + set_host + @my_bike.bike_image.url)
        end
      end
     render json: @my_bike, status: :created
    else
      render json: @my_bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/my_bikes/1
  # PATCH/PUT /web/v1/my_bikes/1.json
  def update
   @my_bike = MyBike.find(params[:id])

   @my_bike.bike = params[:my_bike][:bike]
   unless params[:my_bike][:bike_image].include?"data:image/jpg;base64"
     if @my_bike.bike_changed? && @my_bike.bike_image.url == params[:my_bike][:bike_image].try(:[],:url)
       @my_bike.update(my_bike_params)
       bike_image_with_name
       render json: @my_bike  
      end  
   else
      if @my_bike.update(my_bike_params)
        if params[:my_bike][:bike_image].present? && @my_bike.bike_image.present?
          if set_host == "localhost:3000"
            @my_bike.update(my_bike_image_url: "http://" + set_host + @my_bike.bike_image.url)
          else
            @my_bike.update(my_bike_image_url: "https://" + set_host + @my_bike.bike_image.url)
          end
        else
           set_bike_image(params)
        end
        render json: @my_bike
      else
        render json: @my_bike.errors, status: :unprocessable_entity
      end
    end

end

def set_bike_image(params)
  unless params[:my_bike][:bike_image][:url].present? 
    bike_image_with_name
  end
end

def bike_image_with_name 
     @my_bike.my_bike_image_url = nil
     @my_bike.save
     bike = Bike.find_by_name(@my_bike.bike)
     default_image = DefaultBikeImage.last.image_url
      if bike.present?
        bike_image = bike.default_bike_image.try(:image_url)
        @my_bike.update(bike_id: bike.id, my_bike_image_url: bike_image)
      else
        @my_bike.update(bike_id: 1, my_bike_image_url: default_image)
      end
end

  # DELETE /web/v1/my_bikes/1
  # DELETE /web/v1/my_bikes/1.json
  def destroy
    @my_bike.update_attribute(:status, 'Deleted')
    @my_bike.service_bookings.where(status: 'Active').update_all(status: 'Canceled')
    head :no_content
  end

  private

  def set_my_bike
    @my_bike = MyBike.find(params[:id])
  end

  def my_bike_params
    params.require(:my_bike).permit(:bike, :bike_id, :image_host_url, :purchase_date, :default_bike_image_id, :my_bike_image_url, :registration_number, :insurance_provider, :insurance_number, :insurance_expiry_date, :engine_number, :last_service_date, :user_id, :bike_image, :kms)
  end
end
