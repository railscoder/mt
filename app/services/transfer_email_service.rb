module TransferEmailService
  class << self
    def call
      Company.find_each do |company|
        ActiveRecord::Base.transaction do
          return unless company.emails.first
          company.email = company.emails.first.value
          company.sended = company.emails.first.sended
          company.save
        end
      end
    end
  end
end
