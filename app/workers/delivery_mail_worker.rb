class DeliveryMailWorker
  include Sidekiq::Worker

  def perform
    MailService.call
  end
end
