class Company < ApplicationRecord
  has_many :emails, dependent: :destroy

  belongs_to :category
  belongs_to :city

  validates :site, presence: true
  validates :site, uniqueness: true
end
