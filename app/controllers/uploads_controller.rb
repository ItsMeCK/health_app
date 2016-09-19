class UploadsController < ActionController::Base
  
layout 'application'

    def import
      Bike.import(params[:file])
       flash[:success] = "Bikes Uploaded Successfully"
      redirect_to :back
    end

  def import_specifications
    Specification.import(params[:file])
     flash[:success] = "Specifications Uploaded Successfully"
    redirect_to :back
  end

  def import_users
    User.import(params[:file])
    flash[:success] = "Users Uploaded Successfully"
    redirect_to :back
  end

  def import_service_history
    ServiceHistory.import(params[:file])
     flash[:success] = "Service History Uploaded Successfully"
    redirect_to :back
  end

  def import_prices
    Pricing.import(params[:file])
     flash[:success] = "Prices Uploaded Successfully"
    redirect_to :back
  end

  def import_key_features
    KeyFeature.import(params[:file])
     flash[:success] = "Key Features Uploaded Successfully"
    redirect_to :back
  end

  def import_colors
    BikeColor.import(params[:file])
    flash[:success] = "Bike Colors Uploaded Successfully"
    redirect_to :back
  end

  def import_service_schedules
    ServiceSchedule.import(params[:file])
    flash[:success] = "Service Schedules Uploaded Successfully"
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

  def upload_service_schedules   
  end

 
end
