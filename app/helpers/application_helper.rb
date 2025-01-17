module ApplicationHelper
  # ボトムナビゲーションのだしわけ
  # TravelController#showでユーザーがしおりとリレーションを組んでいる場合true
  def display_bottom_nav?
    controller_name == "travel_books" && action_name == "show" && current_user.travel_books.exists?(id: params[:id])
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
end
