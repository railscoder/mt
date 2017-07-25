module ScanPhoneEmailService
  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

  class << self
    def call(service, category_id)
      Company.where(email: nil, service: service, category_id: category_id).find_each do |company|
        find_email_on_site(company)
      end
    end

    private

    def open_page(url)
      begin
        html = open(url, :allow_redirections => :safe)
        doc = Nokogiri::HTML(html)
      rescue Exception => e
        LoggerService.call(e)
      end
    end

    def get_contact_page(page, full_url)
      return unless page
      contact_link = page.at("a:contains('Контакты')") ||
                     page.at("a:contains('Контакт')") ||
                     page.at("a:contains('контакты')") ||
                     page.at("a:contains('контакт')")

      contact_page = contact_link.first[1] if contact_link
      if contact_page and contact_page.include? ("http")
        url_to_contact_page = contact_page
      elsif  contact_page and contact_page.include? ("/")
        url_to_contact_page = full_url + contact_page
      elsif contact_page
        url_to_contact_page = full_url + "/" +contact_page
      end
    end

    def get_email(page)
      return unless page
      begin
        all_emails = page.to_s.match(EMAIL_REGEX)
        email = all_emails[0] if all_emails
      rescue
      end
    end

    def find_email_on_site(company)
      begin
        full_url = "http://" + company.site
        page = open_page(full_url)
        link_to_contact = get_contact_page(page, full_url)
        email = get_email(page) || get_email(link_to_contact)
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
