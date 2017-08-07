class YandexSearchJob < ApplicationJob
  queue_as :default

  def perform(query, city_id, client)
    YandexSearchService.call(query, city_id, client)
  end
end
