class MailDeliveryWorker
  include Sidekiq::Worker

  def perform(category_id)
    MailService.call(category_id)
  end
end
