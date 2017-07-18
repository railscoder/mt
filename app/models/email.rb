class Email < ApplicationRecord
  belongs_to :company

  validates :value, presence: true
  validate :uniqueness_of_value
end
