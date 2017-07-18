module MailService
  class << self
    def call
      Company.where(sended: false).find_each do |company|
        send_letter(company)
        sleep(60)
      end
    end

    private

    def send_letter(company)
      begin
        ActiveRecord::Base.transaction do
          CompanyMailer.welcome_letter(company.email).deliver_now
          company.sended = true
          company.save
        end
      rescue Exception => e
        LoggerService.call("Error - #{e} from #{email}")
      end
    end
  end
end
