class MailDeliveryWorker
  include Sidekiq::Worker

  def perform
    MailService.call(category_id)
  end
end
