class Company < ApplicationRecord
  belongs_to :category
  belongs_to :city

  validates :site, presence: true
  validates :site, uniqueness: { scope: :client_id }
end
