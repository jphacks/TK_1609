class Favorite < ActiveRecord::Base
  belongs_to :dancer
  belongs_to :record
end
