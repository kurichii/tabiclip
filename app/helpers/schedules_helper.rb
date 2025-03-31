module SchedulesHelper
  def fmt_schedule_date(date)
    return "" if date.nil?
    format_date = date.strftime("%Y/%-m/%-d")
    format_time = date.strftime("%-H:%M")
    "#{format_date}(#{fmt_wday(date)}) #{format_time}"
  end

  def fmt_date_with_day(date)
    return date if date.is_a?(String)
    format_date = date.strftime("%-m/%-d")
    "#{format_date}(#{fmt_wday(date)})"
  end

  def fmt_datetime_range(schedule)
    return t("helpers.undecided") if schedule.start_date.nil? && schedule.end_date.nil?
    start_date = schedule.start_date&.strftime("%H:%M")
    end_date = schedule.end_date&.strftime("%H:%M")
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
