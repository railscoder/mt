module ScanPhoneEmailService
  class << self
    include ScanEmailPhone

    def call(client_id)
      Company.where(client_id: client_id).find_each do |company|
        find_email_on_site(company)
      end
    end

    private

    def find_email_on_site(company)
      begin
        full_url = "http://" + company.site
        page = open_page(full_url)
        link_to_contact = get_contact_page(page, full_url)
        contact_page = open_page(link_to_contact)
        email = get_email(page) || get_email(contact_page)
        phones = get_phone(page) || get_phone(contact_page)
        ActiveRecord::Base.transaction do
          company.email = email
          company.save
          company.phones = phones
          company.save
        end
      rescue Exception => e
        LoggerService.call("Error - #{e} from #{full_url}")
      end
    end
  end
end
