module ApplicationHelper
  # タイトルの動的な変更
  def page_title(title = "")
    base_title = "たびくりっぷ"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  # デフォルトのメタタグを設定
  def default_meta_tags
    {
      site: "たびくりっぷ",
      title: "たびくりっぷ",
      reverse: true,
      charset: "utf-8",
      description: "共有できる旅のしおり作成サービスです",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@https://x.com/kuripiyoco",
        image: image_url("ogp.png")
      }
    }
  end

  # 背景色の出しわけ
  def backgtound_color_class
    controller_name == "home" ? "bg-primary" : "bg-base-200"
  end

  # ボトムナビゲーションのだしわけ判定
  def display_bottom_nav_on_travel_book
    return false if current_user.nil?
    return false if controller_name == "home"
    (controller_name == "travel_books" && action_name == "show" && current_user.travel_books.exists?(uuid: params[:uuid]))||
    (controller_name == "schedules")||
    (controller_name == "notes") ||
    (controller_name == "check_lists") ||
    (controller_name == "list_items")
  end

  # 指定したパスが現在のコントローラーと一致する場合クラスを返す
  def active_class_by_controller(*controllers)
    return "text-gray-500 hover:scale-[1.1]" if action_name == "map"
    controllers.include?(controller_name) ? "text-white hover:scale-[1.1]" : "text-gray-500 hover:scale-[1.1]"
  end

  # 指定したパスが現在のアクションと一致する場合クラスを返す
  def active_class_by_controller_and_action(controller, action)
    controller_name == controller && action_name == action ? "text-white hover:scale-[1.1]" : "text-gray-500 hover:scale-[1.1]"
  end

  # 曜日をフォーマットする
  def fmt_wday(date)
    wdays = %w[日 月 火 水 木 金 土]
    "#{wdays[date.wday]}"
  end

  # フラッシュメッセージの色変更
  def flash_message_color(type)
    case type.to_sym
    when :notice then "bg-green-300 text-green-600 border-green-500"
    when :alert then "bg-red-200 text-red-600 boder border-red-500"
    end
  end
end
