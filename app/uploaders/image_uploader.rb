class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # リサイズしたり画像形式を変更するのに必要
    include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
    if Rails.env.production?
    include Cloudinary::CarrierWave
    else
    storage :file
    end
  # storage :fog

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

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  # 画像の上限を640x480にする
    process :resize_to_limit => [275, 275]
  
  # ファイルサイズに制限をつける
    def size_range
      1..2.megabytes
    end
    
=begin
# アップローダーでどんな種類のものを受け取るか指定
  storage :file

# 保存形式をJPGにする
  process :convert => 'jpg'

# アップロード時に、300*300サイズのサムネイルも保存する
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

# jpg,jpeg,gif,pngしか受け付けない
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

# 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

# ファイル名を日付にすると編集時のデータ受け渡し等で不具合が出るため、ファイル名をランダムで一意にsuる
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end


# アップロードされたファイルを保存するディレクトリをデフォルトに設定する
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
=end
end
