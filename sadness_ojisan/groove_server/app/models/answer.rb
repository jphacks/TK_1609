class Answer < ActiveRecord::Base
  belongs_to :dancer
  belongs_to :question
end
