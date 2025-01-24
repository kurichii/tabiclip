class SchedulesController < ApplicationController
  def index
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @schedules = @travel_book.schedules.sort_by(&:start_date)
  end

  def new
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @schedule = @travel_book.schedules.new
  end

  def create
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @schedule = @travel_book.schedules.build(schedule_param)
    if @schedule.save
      redirect_to travel_book_schedules_path(@travel_book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def schedule_param
    params.require(:schedule).permit(:title, :budged, :memo, :start_date, :end_date)
  end
end
