module SchedulesHelper
  def fmt_date_label(date)
    return date if date.is_a?(String)
    I18n.l(date.to_date, format: :short)
  end

  def fmt_datetime_range(schedule, format)
    Rails.logger.info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    Rails.logger.info "#{schedule.start_date}"
    Rails.logger.info "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    return t("helpers.undecided") if schedule.start_date.nil? && schedule.end_date.nil?
    start_date = schedule.start_date.present? ? I18n.l(schedule.start_date.in_time_zone("Tokyo"), format: format) : ""
    end_date = schedule.end_date.present? ? I18n.l(schedule.end_date.in_time_zone("Tokyo"), format: format) : ""
    Rails.logger.info "#{start_date} - #{end_date}"
    "#{start_date} - #{end_date}"
  end

  def schedule_spot_info(data)
    return content_tag(:li, t(".no_data")) if data.nil?
    content = []
    content << content_tag(:li, data.name) if data.name.present?
    content << content_tag(:li, data.telephone) if data.telephone.present?
    content << content_tag(:li, data.address) if data.address.present?
    safe_join(content)
  end

  def total_budget(schedules)
    schedules.sum { |schedule| schedule.budged.to_i }
  end
end
