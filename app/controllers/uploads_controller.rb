class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    render json: @uploads
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    render json: @upload
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)

    if @upload.save
      render json: @upload, status: :created, location: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    if @upload.update(upload_params)
      head :no_content
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
   def import
    Bike.import(params[:file])
    redirect_to :back, notice: "Successfully Imported Accessories"
  end

 
  def upload_bikes 
  end

  
  private

    def set_upload
      @upload = Upload.find(params[:id])
    end

    def upload_params
      params[:upload]
    end
end
