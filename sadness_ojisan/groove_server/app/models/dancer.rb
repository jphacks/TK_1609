class Dancer < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, confirmation: true
  has_many :favorites
  has_many :records
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :follows
  has_many :api_keys
end
