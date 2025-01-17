module ApplicationHelper
  # 指定したパスが現在のページであれば"active"を返す
  def add_active_class(path)
    "active" if current_page?(path)
  end
end
