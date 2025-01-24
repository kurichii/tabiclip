module SchedulesHelper
  def sum_budgets(schedules)
    schedules.sum { | schedule | schedule.budged.to_i }
  end

  def fmt_date(date)
    date.strftime("%Y年%-m月%-d日(%a)") || ""
  end

  def fmt_datetime(date)
    date.strftime("%H:%M") || "未定"
  end
end
