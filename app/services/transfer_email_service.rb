module TransferEmailService
  class << self
    def call
      Company.find_each do |company|
        unless company.emails.first.empty?
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
