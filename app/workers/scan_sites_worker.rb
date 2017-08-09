class ScanSitesWorker
  include Sidekiq::Worker

  def perform(category_id)
    ScanPhoneEmailService.call(category_id.to_i)
  end
end
