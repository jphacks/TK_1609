class Dancer < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, confirmation: true
end
