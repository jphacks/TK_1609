class Comment < ActiveRecord::Base
  belongs_to :record
  belongs_to :dancer
end
