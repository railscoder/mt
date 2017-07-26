module ScanOneSiteService
  class << self
    include ScanEmail

    def call(site)
      find_email(site)
    end
  end
end
