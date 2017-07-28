module ScanPhoneEmailService
  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  class << self
    include ScanEmail

    def call(source, category_id)
      Company.where(email: nil, source: source, category_id: category_id).find_each do |company|
        find_email_on_site(company)
      end
    end

    private

    def find_email_on_site(company)
      begin
        email = find_email(company.site)
        ActiveRecord::Base.transaction do
          company.email = email
          company.save
        end
      rescue Exception => e
        LoggerService.call("Error - #{e} from #{full_url}")
      end
    end
  end
end
