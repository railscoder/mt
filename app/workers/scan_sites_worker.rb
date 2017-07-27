class ScanSitesWorker
  include Sidekiq::Worker

  def perform(source, category_id)
    ScanPhoneEmailService.call(source, category_id)
  end
end
