class LinebotController < ApplicationController
  skip_before_action :authenticate_user!
  # gem 'line-bot-api'
  require "line/bot"

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: :callback

  def callback
    body = request.body.read
    # リクエストヘッダーの署名を検証しLINEプラットフォームからのリクエストであることを確認
    signature = request.env["HTTP_X_LINE_SIGNATURE"]
    unless LINE_CLIENT.validate_signature(body, signature)
      error 400 do "Bad Request" end
    end

    events = LINE_CLIENT.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          handle_message_event(event)
        when Line::Bot::Event::MessageType::Follow # 友だち追加
          # userId = event["source"]["userId"]
          # Rails.logger.info "#{userId}が友だち追加されました"
          # LINE Developersで挨拶メッセージを登録しています
          # reply(event, "友だち登録ありがとうございます！LINEアカウントとTabiClipアカウントを連携すると、リマインダー機能を使用することができます！アカウント連携するためには、マイページのアカウント連携tokenをコピーして送信してください！")
        when Line::Bot::Event::MessageType::Unfollow # 友だち削除
          userId = event["source"]["userId"]
          user = User.find_by(uid: userId)
          user.update(uid: nil) if user
        end
      end
    end
    # Don't forget to return a successful response
    head :ok
  end

  private

  def handle_message_event(event)
    received_text = event["message"]["text"]
    line_user_id = event["source"]["userId"]

    # 送信されたテキストがパターンマッチしない場合
    return reply(event, "マイページにあるLINEアカウント連携用トークンをコピーして送信してください！") unless received_text.match?(/\A[a-f0-9]{32}\z/)

    # tokenでUserを取得
    user = User.find_by(token: received_text)

    # tokenでuserが特定できない場合
    return reply(event, "無効なtokenです。マイページにあるLINEアカウント連携用トークンを確認してください！") unless user

    # すでにユーザーのuidが登録されている場合
    return reply(event, "LINEアカウントとたびくりっぷアカウントの連携が完了しています！ぜひリマインダー設定してみてくださいね！※LINEログインを利用している場合はすでにアカウントが連携されています") if user.uid

    # ユーザーのuidを更新
    if user.update(uid: line_user_id)
      reply(event, "LINEアカウントとたびくりっぷのアカウント連携が完了しました！")
    else
      reply(event, "LINEアカウントとたびくりっぷのアカウント連携に失敗しました。もう一度tokenを送信してください！")
    end
  end

  def reply(event, text)
    message = {
      type: "text",
      text: text
    }
    LINE_CLIENT.reply_message(event["replyToken"], message)
  end
end
