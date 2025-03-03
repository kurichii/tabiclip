require "line/bot"

LINE_CLIENT = Line::Bot::Client.new { |config|
  config.channel_id = ENV["LINE_CHANNEL_ID"]
  config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
  config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
}
