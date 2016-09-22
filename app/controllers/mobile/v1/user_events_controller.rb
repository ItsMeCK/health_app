class Mobile::V1::UserEventsController < ApplicationController
 	def show
    render json: UserEvent.find(params[:id])
  end
end
