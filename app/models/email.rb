class Email < ApplicationRecord
  belongs_to :company

  validates :value, presence: true
end
