class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, city_ids = [], client, start_page = 1, statt_city_id = 1)
    ScanGisService.call(query, city_id, start_page)
  end
  # Sidekiq::Queue.all.each(&:clear)
  # bundle exec sidekiq -d --logfile logfile2.log
end
