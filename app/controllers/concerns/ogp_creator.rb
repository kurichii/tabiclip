class OgpCreator
  require "mini_magick"
  BASE_IMAGE_PATH = "./app/assets/images/dynamic_ogp_background_image.png"
  GRAVITY = "center"
  TEXT_POSITION = "0,-10"
  TEXT_POSITION_USER = "0,120"
  FONT = "./app/assets/fonts/NotoSansJP-Regular.ttf"
  FONT_SIZE = 60
  FONT_SIZE_USER = 30
  INDENTION_COUNT = 18
  ROW_LIMIT = 3

  def self.build(title, creator)
    title = prepare_text(title)

    image = MiniMagick::Image.open(BASE_IMAGE_PATH)

    # しおりタイトルを合成
    image.combine_options do |config|
      config.font FONT
      config.fill "#707070"
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION} '#{title}'"
    end

    # 作者名を合成
    image.combine_options do |config|
      config.font FONT
      config.fill "#707070"
      config.gravity GRAVITY
      config.pointsize FONT_SIZE_USER
      config.draw "text #{TEXT_POSITION_USER} '作者：#{creator}'"
    end
  end

  private

  # しおりタイトルが長い場合改行を入れる
  def self.prepare_text(title)
    title.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end
end
