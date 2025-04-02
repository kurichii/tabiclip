class ScheduleForm
  include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
  include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする
  # パラメータの読み書きを許可する
  attribute :travel_book_uuid, :string
  attribute :title, :string
  attribute :start_date, :datetime
  attribute :end_date, :datetime
  attribute :budged, :integer, default: 0
  attribute :memo, :string
  attribute :name, :string
  attribute :telephone, :string
  attribute :post_code, :string
  attribute :address, :string
  attribute :schedule_icon_id, :integer

  validates :travel_book_uuid, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validate  :end_date_after_start_date
  validates :budged, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, length: { maximum: 65_535 }
  validates :name, length: { maximum: 255 }
  validates :telephone, length: { maximum: 15 }
  validates :post_code, length: { maximum: 10 }
  validates :address, length: { maximum: 255 }
  validates :schedule_icon_id, inclusion: { in: ScheduleIcon.pluck(:id) }

  # フォームのアクションをPOST/PUTCHに切り替える
  # ScheduleFormオブジェクトがpersisted?メソッドを呼ぶと、Scheduleオブジェクトのpersisted?メソッドが呼び出される
  delegate :persisted?, to: :schedule

  def initialize(attributes = nil, schedule: Schedule.new, spot: nil, travel_book: nil)
    @schedule = schedule
    @spot = spot || @schedule.build_spot
    @travel_book = travel_book

    attributes ||= default_attributes(@travel_book)
    super(attributes)
    # convert_to_jst
  end

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      convert_to_jst
      @schedule = Schedule.create!(title: title, budged: budged, memo: memo, start_date: start_date, end_date: end_date, travel_book_uuid: travel_book_uuid, schedule_icon_id: schedule_icon_id)

      # Spot のデータが存在する場合のみ作成
      if name.present? || telephone.present? || post_code.present? || address.present?
        @spot = Spot.create!(name: name, telephone: telephone, post_code: post_code, address: address, schedule_uuid: schedule.id)
      end
      true
    end
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each do |message|
        errors.add(:base, message)
      end
    false
  end

  def update(attributes)
    return false if invalid?
    ActiveRecord::Base.transaction do
      convert_to_jst
      @schedule.update!(title: title, budged: budged, memo: memo, start_date: start_date, end_date: end_date, travel_book_uuid: travel_book_uuid, schedule_icon_id: schedule_icon_id)

      # Spot のデータが存在する場合のみ作成
      if name.present? || telephone.present? || post_code.present? || address.present?
        @spot.update!(name: name, telephone: telephone, post_code: post_code, address: address, schedule_uuid: @schedule.id)
      else
        @schedule.spot.destroy
      end
    end
    true
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each do |message|
        errors.add(:base, message)
      end
    false
  end

  private

  attr_reader :schedule, :spot

  def default_attributes(travel_book)
    {
      title: schedule.title,
      budged: schedule.budged,
      memo: schedule.memo,
      start_date: schedule.start_date || travel_book&.start_date&.to_datetime || nil,
      end_date: schedule.start_date || travel_book&.start_date&.to_datetime || nil,
      name: spot.name,
      telephone: spot.telephone,
      post_code: spot.post_code,
      address: spot.address,
      schedule_icon_id: schedule.schedule_icon_id || 1
    }
  end

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, :after_start_date)
      false
    end
  end

  def convert_to_jst
    Rails.logger.info "================"
    Rails.logger.info "#{start_date}"
    Rails.logger.info "#{start_date.in_time_zone("Asia/Tokyo")}"
    self.start_date = Time.zone.parse(start_date.to_s) if start_date.present?
    Rails.logger.info "================"
    Rails.logger.info "#{Time.zone.name}"
    Rails.logger.info "#{self.start_date}"
    Rails.logger.info "================"
    self.end_date = Time.zone.parse(end_date.to_s) if end_date.present?
  end
end
