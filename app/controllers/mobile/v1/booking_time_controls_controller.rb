class Mobile::V1::BookingTimeControlsController < ApplicationController

  def find_book_time_controls
    @book_time_control = BookingTimeControl.where('category = ? AND weekday = ?', params[:category], params[:weekday])
    render json: @book_time_control
  end

end
