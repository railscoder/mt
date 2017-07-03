class Email < ApplicationRecord
  belongs_to :company

  validates :value, presence: true
  validates :value, uniqueness: true
end
