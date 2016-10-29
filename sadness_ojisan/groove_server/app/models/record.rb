class Record < ActiveRecord::Base
  mount_uploader :movie, MovieUploader
  belongs_to :dancer
  belongs_to :music
  has_many :favorites
  has_many :comments
end
