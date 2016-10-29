class Record < ActiveRecord::Base
  belongs_to :dancer
  belongs_to :music
  has_many :favorites
  has_many :comments
end
