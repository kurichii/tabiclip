class PushMessageService
  def self.call(user, list_item)
    return unless user.uid

    message = {
      type: "text",
      text: "#{user.name}さん！ 「#{list_item.title}」の時間です！"
    }

    response = LINE_CLIENT.push_message(user.uid, message)
    Rails.logger.info "Success!!!PushLine"
  end
end
