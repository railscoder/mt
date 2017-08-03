class YandexSearchJob < ApplicationJob
  queue_as :default

  def perform(query, city_id)
    YandexSearchService.call(query, city_id)
  end
end
