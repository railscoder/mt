class Company < ApplicationRecord
  has_many :emails
  has_many :phones

  validates :site, presence: true
end
