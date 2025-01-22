class SchedulesController < ApplicationController
  def index
    travel_book = current_user.travel_books.find(params[:travel_book_id])
    @schedules = travel_book.schedules
  end
end
