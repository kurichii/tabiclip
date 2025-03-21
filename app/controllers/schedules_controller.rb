class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :edit, :update, :destroy ]
  before_action :set_travel_book, only: %i[ index new create map ]
  before_action :set_schedule, only: %i[ show edit update destroy ]

  def index
    @schedules = @travel_book.sorted_schedules
    # scheduleには0もしくは1のspotがひも付くため、spotが紐づいていて緯度情報が存在するもののみ格納する
    @spots = @schedules.map(&:spot).compact.select { |spot| spot.latitude.present? }
  end

  def new
    @schedule_form = ScheduleForm.new(travel_book: @travel_book)
  end

  def create
    @schedule_form = ScheduleForm.new(schedule_params)
    if @schedule_form.save
      redirect_to travel_book_schedules_path(@travel_book), notice: t("defaults.flash_message.created", item: Schedule.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Schedule.model_name.human)
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
      redirect_to travel_book_schedules_path(@travel_book), notice: t("defaults.flash_message.updated", item: Schedule.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Schedule.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy!
    redirect_to travel_book_schedules_path(@travel_book), notice: t("defaults.flash_message.deleted", item: Schedule.model_name.human)
  end

  def map
    @schedules = @travel_book.sorted_schedules
    # scheduleには0もしくは1のspotがひも付くため、spotが紐づいていて緯度情報が存在するもののみ格納する
    @spots = @schedules.map(&:spot).compact.select { |spot| spot.latitude.present? }
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
      :schedule_icon_id
    ).merge(
      travel_book_uuid: @travel_book.id
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
