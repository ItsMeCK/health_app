class Mobile::V1::BookingTimeControlsController < ApplicationController

  def find_book_time_controls(booking_time_control_params)
    @book_time_control = BookingTimeControl.where('category = ? AND weekday = ?', params[:category], params[:weekday])
    render json: @book_time_control
  end


  private

  def booking_time_control_params
    params.require(:booking_time_control).permit(:category, :weekday)
  end

end
