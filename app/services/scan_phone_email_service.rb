module ScanPhoneEmailService
  class << self
    include ScanEmailPhone

    def call(client_id)
      Company.where(client_id: client_id).find_each do |company|
        find_email_on_site(company.site)
      end
    end

    private

    def find_email_on_site(site)
      begin
        find_email_phone(site)
        email =  info[0]
        phones = info[1]
        ActiveRecord::Base.transaction do
          company.email = email
          company.phones = phones
          company.save
        end
      rescue Exception => e
        LoggerService.call("Error - #{e} from #{full_url}")
      end
    end
  end
end
