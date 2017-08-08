class YandexSearchJob < ApplicationJob
  queue_as :default

  def perform(city_id, client)
    File.open("queries.txt", "r").each_line do |query|
      YandexSearchService.call(query.chomp, city_id, client)
      sleep(30)
    end
  end
end
