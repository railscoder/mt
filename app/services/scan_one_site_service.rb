module ScanOneSiteService
  class << self
    include ScanEmailPhone

    def call(site)
      info = find_email_phone(site)
      email =  info[0]
      phones = info[1]
      Company.create(site: site, email: email, phones: phones, category_id: 1, city_id: 1).errors
    end
  end
end
