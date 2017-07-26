module ScanEmail
  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i

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

  def find_email(site)
    full_url = "http://" + site
    page = open_page(full_url)
    link_to_contact = get_contact_page(page, full_url)
    contact_page = open_page(link_to_contact)
    email = get_email(page) || get_email(contact_page)
  end
end
