module MailService
  SLEEP_TIME = 60

  class << self
    def call(category_id)
      Company.where(category_id: catefgory_id, sended: false).find_each do |company|
        send_letter(company)
        sleep(SLEEP_TIME)
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
