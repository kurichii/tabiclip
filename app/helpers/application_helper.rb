module ApplicationHelper
  # ボトムナビゲーションのだしわけ判定
  def display_bottom_nav_on_travel_book
    return false if current_user.nil?
    return false if controller_name == "home"
    (controller_name == "travel_books" && action_name == "show" && current_user.travel_books.exists?(id: params[:id]))||
    (controller_name == "schedules")||
    (controller_name == "check_lists") ||
    (controller_name == "list_items")
  end

  # 指定したパスが現在のページであれば"active"を返す
  def add_active_class(path)
    current_page?(path) ? "hover:bg-base-200" : "hover:bg-base-200 opacity-50"
  end

  # 日付をフォーマットする
  def fmt_date(date)
    return "未定" if date.nil?
    date.strftime("%Y/%-m/%-d(%a)")
  end

  def flash_message_color(type)
    type.to_sym == :notice ? "alert-success" : "alert-error"
  end
end
