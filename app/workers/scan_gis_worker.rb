class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, city_id, category_id, source)
    ScanGisService.call(query, city_id, category_id, source)
  end
end
