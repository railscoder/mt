class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, city_id)
    ScanGisService.call(query, city_id)
  end
  # Sidekiq::Queue.all.each(&:clear)
end
