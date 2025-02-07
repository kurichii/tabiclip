class SchedulesController < ApplicationController
  before_action :set_travel_book, only: %i[ index new create ]
  before_action :set_schedule, only: %i[ show edit update destroy ]

  def index
    @schedules = @travel_book.sorted_schedules
  end

  def new
    @schedule_form = ScheduleForm.new(travel_book:@travel_book)
  end

  def create
    @schedule_form = ScheduleForm.new(schedule_params)
    if @schedule_form.save
      redirect_to travel_book_schedules_path(@travel_book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    @spot = @schedule.spot
    @schedule_form = ScheduleForm.new(schedule: @schedule, spot: @spot)
  end

  def update
    @spot = @schedule.spot
    @schedule_form = ScheduleForm.new(schedule_params, schedule: @schedule, spot: @spot)
    if @schedule_form.update(schedule_params)
      redirect_to schedule_path(@schedule), notice: "登録成功"
    else
      flash.now[:alert] = "編集失敗"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy!
    redirect_to travel_book_schedules_path(@travel_book), notice: "削除成功"
  end

  private

  def schedule_params
    params.require(:schedule_form).permit(
      :title,
      :start_date,
      :end_date,
      :budged,
      :memo,
      :name,
      :telephone,
      :post_code,
      :address,
    ).merge(
      travel_book_id: @travel_book.id
    )
  end

  def set_travel_book
    @travel_book = TravelBook.find(params[:travel_book_id])
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
    @travel_book = @schedule.travel_book
  end
end
