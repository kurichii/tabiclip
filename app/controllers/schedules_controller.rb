class SchedulesController < ApplicationController
  before_action :set_travel_book, only: %i[ index new create ]
  before_action :set_schedule, only: %i[ show edit update destroy ]

  def index
    @schedules = @travel_book.schedules.sort_by(&:start_date)
  end

  def new
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @schedule = @travel_book.schedules.new
    # Scheduleのstart_dateの初期値を設定
    if @travel_book.start_date.present?
      @schedule.start_date = @travel_book.start_date.to_datetime
    end
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

  def show
    @travel_book = @schedule.travel_book
  end

  def edit
    @travel_book = @schedule.travel_book
  end

  def update
    if @schedule.update(schedule_param)
      redirect_to schedule_path(@schedule), notice: "登録成功"
    else
      flash.now[:alert] = "編集失敗"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy!
    @travel_book = @schedule.travel_book
    redirect_to travel_book_schedules_path(@travel_book), notice: "削除成功"
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
