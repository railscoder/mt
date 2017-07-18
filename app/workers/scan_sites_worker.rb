class ScanSitesWorker
  include Sidekiq::Worker

  def perform
    ScanPhoneEmailService.call
  end
end
