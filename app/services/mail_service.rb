module MailService
  class << self
    def call
      Email.where(sended: false).find_each do |email|
        begin
          ActiveRecord::Base.transaction do
            CompanyMailer.welcome_letter(email.value).deliver_now
            email.sended = true
            email.save
          end
        rescue Exception => e
          LoggerService.call("Error - #{e} from #{email}")
        end
        sleep(60)
      end
    end
  end
end
