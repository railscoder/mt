class Company < ApplicationRecord
  has_many :emails
  has_many :phones

  belongs_to :category
  belongs_to :store
  belongs_to :city

  validates :site, presence: true
end
