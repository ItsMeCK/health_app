class Web::V1::DealerContactLabelsController < ApplicationController
  before_action :set_dealer_contact_label, only: [:show, :update, :destroy]

  # GET /web/v1/dealer_contact_labels
  # GET /web/v1/dealer_contact_labels.json
  def index
    @dealer_contact_labels = DealerContactLabel.all

    render json: @dealer_contact_labels
  end

  # GET /web/v1/dealer_contact_labels/1
  # GET /web/v1/dealer_contact_labels/1.json
  def show
    render json: @dealer_contact_label
  end

  # POST /web/v1/dealer_contact_labels
  # POST /web/v1/dealer_contact_labels.json
  def create
    @dealer_contact_label = DealerContactLabel.new(dealer_contact_label_params)

    if @dealer_contact_label.save
      render json: @dealer_contact_label, status: :created
    else
      render json: @dealer_contact_label.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/dealer_contact_labels/1
  # PATCH/PUT /web/v1/dealer_contact_labels/1.json
  def update
    @dealer_contact_label = DealerContactLabel.find(params[:id])

    if @dealer_contact_label.update(dealer_contact_label_params)
      head :no_content
    else
      render json: @dealer_contact_label.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/dealer_contact_labels/1
  # DELETE /web/v1/dealer_contact_labels/1.json
  def destroy
    @dealer_contact_label.destroy

    head :no_content
  end

  private

    def set_dealer_contact_label
      @dealer_contact_label = DealerContactLabel.find(params[:id])
    end

    def dealer_contact_label_params
      params.require(:dealer_contact_label).permit(:label_name)
    end
end
