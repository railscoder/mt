class Email < ApplicationRecord

  validates :value, presence: true
  validate :uniqueness_of_value

  private

    def uniqueness_of_value
      Email.find_by(value: value)
    end
end
