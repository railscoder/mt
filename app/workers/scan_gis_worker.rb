class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, city_id, start_page = 1)
    ScanGisService.call(query, city_id, start_page)
  end
  # Sidekiq::Queue.all.each(&:clear)
end
