class Mobile::V1::FinanceDocumentsController < ApplicationController
  before_action :set_finance_document, only: [:show]

  # GET /web/v1/finance_documents
  # GET /web/v1/finance_documents.json
  # def index
  #   @finance_documents = FinanceDocument.all

  #   render json: @finance_documents
  # end

  # GET /web/v1/finance_documents/1
  # GET /web/v1/finance_documents/1.json
  def show
    render json: @finance_document
  end

  # POST /web/v1/finance_documents
  # POST /web/v1/finance_documents.json
  

  private

    def set_finance_document
      @finance_document = FinanceDocument.find(params[:id])
    end

end
