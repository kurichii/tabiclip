class ReminderPushJob < ApplicationJob
  queue_as :default

  # Sideliqはジョブ実行失敗時デフォルトで25回リトライするため、通知が1回しか送られないように1回に指定
  sidekiq_options retry: 1

  # ジョブのリトライ感覚を60秒に設定
  sidekiq_retry_in do |_count|
    60
  end

  def perform(*args)
    PushMessageService.call
  end
end
