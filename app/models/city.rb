class City < ApplicationRecord
  has_many :companies

  validates :name, presence: true
  validates :name, uniqueness: true
end
