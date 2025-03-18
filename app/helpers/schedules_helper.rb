module SchedulesHelper
  def fmt_schedule_date(date)
    return "" if date.nil?
    date.strftime("%Y/%-m/%-d/(%a) %-H:%M")
  end

  def fmt_date_with_day(date)
    return date if date.is_a?(String)
    date.strftime("%-m/%-d(%a)")
  end

  def fmt_datetime(date)
    return "" if date.nil?
    date.strftime("%-H:%M")
  end

  def fmt_date_with_datetime(date)
    return "" if date.nil?
    date.strftime("%-m/%-d %-H:%M")
  end

  def fmt_schedule_duration(schedule)
    if schedule.start_date && schedule.end_date
      "#{fmt_schedule_date(schedule.start_date)} - #{fmt_datetime(schedule.end_date)}"
    elsif schedule.start_date || schedule.end_date
      "#{fmt_schedule_date(schedule.start_date)} - #{fmt_schedule_date(schedule.end_date)}".strip
    else
      t("helpers.undecided")
    end
  end

  def fmt_schedule_datetime_duration(schedule)
    return t("helpers.undecided") unless schedule.start_date || schedule.end_date
    "#{fmt_datetime(schedule.start_date)} - #{fmt_datetime(schedule.end_date)}"
  end

  def fmt_all_day_schedule_datetime_duration(schedule)
    return t("helpers.undecided") unless schedule.start_date || schedule.end_date
    "#{fmt_date_with_datetime(schedule.start_date)} - #{fmt_date_with_datetime(schedule.end_date)}"
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
