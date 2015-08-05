# encoding: utf-8

class PortraitUploader < CarrierWave::Uploader::Base
 include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :big do
    process :resize_to_fit => [1000, nil]
  end

  version :medium do
    process :resize_to_fit => [500, nil]
  end

  version :small do
    process :resize_to_fit => [200, nil]
  end

  version :square do
    process :resize_to_fill => [300, 300]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    if !model.group
      'artist-portrait.png'
    else
      'group-portrait.png'
    end
  end
end
