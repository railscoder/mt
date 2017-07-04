class City < ApplicationRecord
  has_many :companies

  validates :eng_name, :rus_name, presence: true
  validates :eng_name, :rus_name, uniqueness: true
end
