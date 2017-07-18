class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, city_id, source)
    ScanGisService.call(query, city_id, source)
  end
  # Sidekiq::Queue.all.each(&:clear)
end
