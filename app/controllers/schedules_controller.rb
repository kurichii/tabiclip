class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ index new create ]
  before_action :set_schedule, only: %i[ show edit update ]

  def index
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

  def show; end

  def edit; end

  def update
    if @schedule.update(schedule_param)
      redirect_to schedule_path(@schedule), notice: "登録成功"
    else
      flash.now[:alert] = "編集失敗"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_travel_book
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_param
    params.require(:schedule).permit(:title, :budged, :memo, :start_date, :end_date)
  end
end
