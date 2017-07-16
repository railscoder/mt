class Email < ApplicationRecord
  belongs_to :company

  validates :value, presence: true
  validate :uniqueness_of_value

  private

    def uniqueness_of_value
      Email.find_by(value: value)
    end
end
