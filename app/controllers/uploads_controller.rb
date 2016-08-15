class UploadsController < ActionController::Base
  

    def import
      Bike.import(params[:file])
      redirect_to :back
    end

  def import_specifications
    Specification.import(params[:file])
    redirect_to :back
  end

  def import_users
    User.import(params[:file])
    redirect_to :back
  end

  def import_service_history
    ServiceHistory.import(params[:file])
    redirect_to :back
  end

  def import_prices
    Pricing.import(params[:file])
    redirect_to :back
  end

  def import_key_features
    KeyFeature.import(params[:file])
    redirect_to :back
  end

  def import_colors
    BikeColor.import(params[:file])
    redirect_to :back
  end

  def upload_bikes
  end

  def upload_specifications   
  end

  def upload_users   
  end

  def upload_service_history   
  end

  def upload_prices   
  end

  def upload_key_features   
  end

  def upload_colors   
  end

 
end
