class MailDeliveryWorker
  include Sidekiq::Worker

  def perform
    MailService.call
  end
end
