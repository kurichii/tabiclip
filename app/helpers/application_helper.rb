module ApplicationHelper
  # ボトムナビゲーションのだしわけ
  # TravelController#showでユーザーがしおりとリレーションを組んでいる場合true
  def display_bottom_nav?
    return false if current_user.nil?
    (controller_name == "travel_books" && action_name == "show" && current_user.travel_books.exists?(id: params[:id]))|| controller_name == "schedules"
  end

  # 指定したパスが現在のページであれば"active"を返す
  def add_active_class(path)
    if path == travel_books_path && (request.fullpath == root_path || request.fullpath == travel_books_path)
      "active"
    elsif request.fullpath == path
      "active"
    else
      ""
    end
  end

  # 日付をフォーマットする
  def fmt_date(date)
    return "未定" if date.nil?
    date.strftime("%Y/%-m/%-d(%a)")
  end

  def flash_message_color(type)
    colors = {
      success: "alert-success",
      notice: "alert-success",
      error: "alert-error",
      alert: "alert-error"
    }
    colors[type.to_sym] || "bg-gray-300"
  end
end
