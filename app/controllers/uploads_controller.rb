class UploadsController < ActionController::Base
  

  def import
    Bike.import(params[:file])
    redirect_to :back
  end

  def import_specifications
    Specification.import(params[:file])
    redirect_to :back
  end

  def upload_bikes
  end

  def upload_specifications   
  end

 
end
