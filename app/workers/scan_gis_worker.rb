class ScanGisWorker
  include Sidekiq::Worker

  def perform(query, client, city_ids = [], start_page=1, start_city_id=1)
    ScanGisService.call(query, client, city_ids, start_page, start_city_id)
  end
  # Sidekiq::Queue.all.each(&:clear)
  # bundle exec sidekiq -d --logfile logfile2.log
end
