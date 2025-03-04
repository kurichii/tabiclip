# SupportRequest/20250304
class ReminderPushJob < ApplicationJob
  queue_as :default

  # Sideliqはジョブ実行失敗時デフォルトで25回リトライするため、通知が1回しか送られないように1回に指定
  sidekiq_options retry: 1

  # ジョブのリトライ感覚を60秒に設定
  sidekiq_retry_in do |_count|
    60
  end

  def perform(*args)
    # argsでリストアイテムのidを受け取る
    list_item = ListItem.find(args[0])
    # リマインダー設定されたリストアイテムが紐づいたしおりを所有するユーザーを配列へ格納
    users = User.joins(travel_books: :check_lists).where(check_lists: { uuid: list_item.check_list.uuid }).select(:uid, :name)

    users.each do |user|
      PushMessageService.call(user, list_item)
    end
  end
end
