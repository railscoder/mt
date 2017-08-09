class DeliveryMailWorker
  include Sidekiq::Worker

  def perform(client_id)
    MailService.call(client_id.to_i)
  end
end
