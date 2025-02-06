module SchedulesHelper
  def sum_budgets(schedules)
    schedules.sum { | schedule | schedule.budged.to_i }
  end

  def fmt_schedule_date(date)
    return "" if date.nil?
    date.strftime("%Y/%-m/%-d/(%a) %-H:%M")
  end

  def fmt_simple_date(date)
    return date if date.is_a?(String)  # 文字列ならそのまま返す
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
      "未定"
    end
  end

  def fmt_schedule_datetime_duration(schedule)
    if schedule.start_date && schedule.end_date
      "#{fmt_datetime(schedule.start_date)} - #{fmt_datetime(schedule.end_date)}"
    elsif schedule.start_date || schedule.end_date
      "#{fmt_datetime(schedule.start_date)} - #{fmt_datetime(schedule.end_date)}".strip
    else
      "未定"
    end
  end

  def fmt_all_day_schedule_datetime_duration(schedule)
    if schedule.start_date && schedule.end_date
      "#{fmt_date_with_datetime(schedule.start_date)} - #{fmt_date_with_datetime(schedule.end_date)}"
    elsif schedule.start_date || schedule.end_date
      "#{fmt_date_with_datetime(schedule.start_date)} - #{fmt_date_with_datetime(schedule.end_date)}".strip
    else
      "未定"
    end
  end

  def desplay_value(data)
    data.presence || ""
  end

  def display_memo(data)
    data == "" ? "メモはありません" : data
  end

  def total_budget(schedules)
    schedules.sum { |schedule| schedule.budged.to_i }
  end
end
