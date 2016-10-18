class Mobile::V1::AyurvedaDincharyasController < InheritedResources::Base

  def index
    @ayu_dins = AyurvedaDincharya.all
    render json: @ayu_dins  #each_serializer: Web::V1::BikeSerializer
  end


  # GET /web/v1/bikes/1
  # GET /web/v1/bikes/1.json
  def show
    render json: AyurvedaDincharya.find_by_id(params[:id])  #serializer: Web::V1::BikeSerializer
  end

  # POST /web/v1/bikes
  # POST /web/v1/bikes.json
  def create
    @ayu_din = AyurvedaDincharya.new(bike_params)

    if @ayu_din.save
      render json: @ayu_din, status: :created #serializer: Web::V1::BikeSerializer
    else
      render json: @ayu_din.errors, status: :unprocessable_entity
    end
  end




  private

    def ayurveda_dincharya_params
      params.require(:ayurveda_dincharya).permit(:sleep_time, :wake_up_time, :break_fast_time, :lunch, :snacks_time, :sports, :hobbies, :dinner)
    end
end

