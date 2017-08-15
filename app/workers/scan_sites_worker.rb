class ScanSitesWorker
  include Sidekiq::Worker

  def perform(client_id, category_id)
    ScanPhoneEmailService.call(client_id, category_id)
  end
end
