module MailService
  SLEEP_TIME = 60

  class << self
    def call(client_id)
      Company.where(client_id: client_id).find_each do |company|
        send_letter(company)
        sleep(SLEEP_TIME)
      end
    end

    private

    def send_letter(company)
      begin
        ActiveRecord::Base.transaction do
          CompanyMailer.email_marketing(company.email).deliver_now
          company.sended = true
          company.save
        end
      rescue Exception => e
        LoggerService.call("Error - #{e} from #{email}")
      end
    end
  end
end
