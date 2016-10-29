# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def fog_attributes
    {
      'Content-Type' =>  'image/png'
    }
  end

end
