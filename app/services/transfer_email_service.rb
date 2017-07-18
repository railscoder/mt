module TransferEmailService
  class << self
    def call
      Company.find_each do |company|
        if company.emails.first
          ActiveRecord::Base.transaction do
            company.email = company.emails.first.value
            company.sended = company.emails.first.sended
            company.save
          end
        end
      end
    end
  end
end
