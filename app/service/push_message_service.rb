class PushMessageService
  def self.call
    new.call
  end

  def call
    send_push_message
  end

  private

  def send_push_message
    # 現在時刻を秒を0に統一
    now = Time.zone.now.change(sec: 0)
    # 現在時刻から1分間の範囲を指定
    range = now..(now + 59.seconds)
    users = User.all
    users.each do |user|
      # しおり,チェックリスト,リストアイテム,リマインダーを内部結合し、現在時刻にリマインダー登録されているリストアイテムのタイトルを取得
      reminder_items = user.travel_books.joins(check_lists: { list_items: :reminder }).where(reminders: { reminder_date: range }).pluck("list_items.title")
      if reminder_items != []
        message = {
          type: "text",
          text: "「#{reminder_items.join(",")}」の時間です！"
        }
        response = LINE_CLIENT.push_message(user.uid, message)
        Rails.logger.info "Success!!!PushLine"
        Rails.logger.info "Push message response: #{response.inspect}"
      end
    end
  end
end
