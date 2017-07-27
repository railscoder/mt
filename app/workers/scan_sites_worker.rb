class ScanSitesWorker
  include Sidekiq::Worker

  def perform
    ScanPhoneEmailService.call(source, category_id)
  end
end
