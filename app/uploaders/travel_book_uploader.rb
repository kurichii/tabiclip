class TravelBookUploader < CarrierWave::Uploader::Base
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
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  def default_url
    "default_travel_book_image.jpg"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  process resize_to_fit: [ 800, 250 ]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end
  # version :travel_book_show do
  #   process resize_to_fit: [800, 250]
  # end

  # version :travel_book_index do
  #   process resize_to_fit: [300, 200]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  def extension_allowlist
    %w[ jpg jpeg gif png ]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end
end
