class Record < ActiveRecord::Base
  belongs_to :dancer
  belongs_to :music
end
