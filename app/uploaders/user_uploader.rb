class UserUploader < CarrierWave::Uploader::Base
  # Include RMagick, MiniMagick, or Vips support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWave::Vips

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog
  # 本番環境と開発・テスト環境で保存先を分ける
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "icon.webp"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  process resize_to_fit: [ 80, 80 ]

  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[ jpg jpeg gif png heic webp ]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end

  # WebPに変換
  process :convert_to_webp

  def convert_to_webp
    manipulate! do |img|
      img.format "webp"
      img
    end
  end

  def filename
    super.chomp(File.extname(super)) + ".webp" if original_filename.present?
  end
end
