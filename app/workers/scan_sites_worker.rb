class ScanSitesWorker
  include Sidekiq::Worker

  def perform(client_id)
    ScanPhoneEmailService.call(client_id.to_i)
  end
end
