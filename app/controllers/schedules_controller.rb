class SchedulesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show map ]
  before_action :set_travel_book, only: %i[ index new create map ]
  before_action :set_schedule, only: %i[ show edit update destroy ]

  def index
    authorize(@travel_book, policy_class: SchedulePolicy)
    # scheduleには0以上のspotがひも付くため、spotが紐づいていて緯度情報が存在するもののみ格納する
    # スケジュール一覧では初日を初期表示するためindexでは初日のデータのみ取得する
    @schedules = @travel_book.sorted_schedules
    first_date = @schedules.map { |s| s.start_date&.to_date }.compact.min
    @spots = @schedules
    .select { |s| s.start_date&.to_date == first_date && s.spot&.latitude.present? }
    .map { |s| { id: s.spot.id, latitude: s.spot.latitude, longitude: s.spot.longitude, name: s.spot.name, schedule_uuid: s.uuid } }
  end

  def new
    authorize(@travel_book, policy_class: SchedulePolicy)
    @schedule_form = ScheduleForm.new(travel_book: @travel_book)
  end

  def create
    @schedule_form = ScheduleForm.new(schedule_params)

    if @schedule_form.save
      redirect_to travel_book_schedules_path(@travel_book.uuid), notice: t("defaults.flash_message.created", item: Schedule.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Schedule.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize(@travel_book, policy_class: SchedulePolicy)
  end

  def edit
    authorize(@travel_book, policy_class: TravelBookOwnerPolicy)
    @spot = @schedule.spot
    @schedule_form = ScheduleForm.new(schedule: @schedule, spot: @spot)
  end

  def update
    authorize(@travel_book, policy_class: TravelBookOwnerPolicy)
    @spot = @schedule.spot
    @schedule_form = ScheduleForm.new(schedule_params, schedule: @schedule, spot: @spot)

    if @schedule_form.update(schedule_params)
      redirect_to travel_book_schedules_path(@travel_book.uuid), notice: t("defaults.flash_message.updated", item: Schedule.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Schedule.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@travel_book, policy_class: TravelBookOwnerPolicy)
    @schedule.destroy!
    redirect_to travel_book_schedules_path(@travel_book.uuid), notice: t("defaults.flash_message.deleted", item: Schedule.model_name.human)
  end

  def map
    authorize(@travel_book, policy_class: SchedulePolicy)
    @schedules = @travel_book.sorted_schedules
    # scheduleには0もしくは1のspotがひも付くため、spotが紐づいていて緯度情報が存在するもののみ格納する
    @spots = @schedules
    .select { |s| s.spot&.latitude.present? }
    .map { |s| { id: s.spot.id, latitude: s.spot.latitude, longitude: s.spot.longitude, name: s.spot.name, schedule_uuid: s.uuid } }
  end

  private

  def schedule_params
    params.require(:schedule_form).permit(
      :title,
      :start_date,
      :end_date,
      :budget,
      :memo,
      :name,
      :telephone,
      :post_code,
      :address,
      :schedule_icon_id,
      :schedule_image,
      :schedule_image_cache
    ).merge(
      travel_book_id: @travel_book.id
    )
  end

  def set_travel_book
    @travel_book = TravelBook.find_by!(uuid: params[:travel_book_uuid])
  end

  def set_schedule
    @schedule = Schedule.find_by!(uuid: params[:uuid])
    @travel_book = @schedule.travel_book
  end
end
